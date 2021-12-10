import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MAReqListController extends GetxController {
  final log = getLogger('MA Requests List Controller');
  final AppController appController = Get.find();
  final NavigationController navigationController = Get.find();
  final TextEditingController reason = TextEditingController();
  final RxList<MARequestModel> maRequests = RxList<MARequestModel>([]);
  final RxList<MARequestModel> filteredList = RxList<MARequestModel>();
  final TextEditingController maFilter = TextEditingController();
  final RxString type = ''.obs;
  final RxBool isLoading = true.obs;
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final MenuController menuController = Get.find();
  final RxBool showFilteredResult = false.obs;

  @override
  void onReady() {
    super.onReady();
    maRequests.bindStream(getMARequests());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  Stream<List<MARequestModel>> getMARequests() {
    log.i('MA Requests List Controller | get Collection');
    return firestore
        .collection('ma_request')
        .orderBy('date_rqstd')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return MARequestModel.fromJson(item.data());
      }).toList();
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  void refresh() {
    showFilteredResult.value = false;
    // filteredList.clear();
    // filteredList.assignAll(maRequests);
  }

  void filter({required String name, required String type}) {
    final RxList<MARequestModel> temp = RxList<MARequestModel>();
    filteredList.clear();
    final RxBool madeChanges = false.obs;

    //filter for name only
    if (name != '') {
      print('NAME');
      for (var i = 0; i < maRequests.length; i++) {
        madeChanges.value = true;
        if (maRequests[i]
            .fullName!
            .toLowerCase()
            .contains(name.toLowerCase())) {
          filteredList.add(maRequests[i]);
        }
      }
    }

    //filter for type only
    if (type != '' && type != 'All') {
      if (filteredList.isEmpty) {
        for (var i = 0; i < maRequests.length; i++) {
          madeChanges.value = true;
          if (maRequests[i].type == type) {
            filteredList.add(maRequests[i]);
          }
        }
      } else {
        for (var i = 0; i < filteredList.length; i++) {
          if (filteredList[i].type == type) {
            temp.add(filteredList[i]);
          }
        }
        filteredList.clear();
        filteredList.assignAll(temp);
      }
    }

    //show all
    if (!madeChanges.value && filteredList.isEmpty) {
      print('ALL');
      filteredList.assignAll(maRequests);
    }
    showFilteredResult.value = true;
  }

  void goBack() {
    return navigationController.navigatorKey.currentState!.pop();
  }

  Future<void> acceptMA(GeneralMARequestModel model) async {
    showLoading();
    await firestore
        .collection('on_progress_ma')
        .doc(model.maID)
        .set(<String, dynamic>{
      'maID': model.maID,
      'requesterID': model.requesterID,
      'fullName': model.fullName,
      'age': model.age,
      'address': model.address,
      'gender': model.gender,
      'type': model.type,
      'prescriptions': model.prescriptions,
      'dateRqstd': model.dateRqstd,
      'validID': model.validID,
      'isTransferred': false,
      'receivedBy': fetchedData!.firstName,
      'receiverID': fetchedData!.userID,
      'isAccepted': true,
      'isApproved': false,
      'isMedReady': false,
      'medWorth': '',
      'pharmacy': '',
    }).then((value) async {
      await sendNotificationAccepted(model.requesterID!);
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      refresh();
      menuController.changeActiveItemTo('Dashboard');
      navigationController.navigateTo(Routes.DASHBOARD);
    });
  }

  Future<void> sendNotificationAccepted(String uid) async {
    final action = ' has accepted your ';
    final title = 'The pswd personnel${action}Medical Assistance(MA) Request';
    final message =
        'Please standby and get ready for an interview through video call';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': maLogoURL,
      'from': 'The pswd personnel',
      'action': action,
      'subject': 'MA Request',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await appController.sendNotificationViaFCM(title, message, uid);

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': FieldValue.increment(1),
    });
  }

  Future<void> declineMARequest(String maID, String requesterID) async {
    showLoading();
    await updatePatientStatus(requesterID);
    await addNotification(requesterID);
    await deleteMAFromQueue(maID);
    await deleteMA(maID);
    dismissDialog(); //dismiss Loading
    dismissDialog(); //dismiss Popup Dialog
    menuController.changeActiveItemTo('Dashboard');
    navigationController.navigateTo(Routes.DASHBOARD);
  }

  Future<void> deleteMA(String maID) async {
    await firestore
        .collection('ma_request')
        .doc(maID)
        .delete()
        .then((value) => print("MA Request Deleted"))
        .catchError((error) => print("Failed to delete MA Request"));
  }

  Future<void> deleteMAFromQueue(String maID) async {
    await firestore
        .collection('ma_queue')
        .doc(maID)
        .delete()
        .then((value) => print("MA Req Deleted in Queue"))
        .catchError((error) => print("Failed to delete ma req in queue"));
  }

  Future<void> updatePatientStatus(String patientID) async {
    await firestore
        .collection('patients')
        .doc(patientID)
        .collection('status')
        .doc('value')
        .update({'hasActiveQueueMA': false, 'queueMA': ''});
  }

  Future<void> addNotification(String uid) async {
    final action = ' has denied your ';
    final title = 'The pswd personnel${action}Medical Assistance(MA) Request';
    final message = '"${reason.text}"';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': maLogoURL,
      'from': 'The pswd personnel',
      'action': action,
      'subject': 'MA Request',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await appController.sendNotificationViaFCM(title, message, uid);

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': FieldValue.increment(1),
    });
  }
}
