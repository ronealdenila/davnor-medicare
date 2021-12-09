import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnProgressReqController extends GetxController {
  final log = getLogger('On Progress Req Controller');
  static AppController appController = Get.find();
  final pharmacyController = TextEditingController();
  final worthController = TextEditingController();
  final NavigationController navigationController = Get.find();
  final RxList<OnProgressMAModel> onProgressList =
      RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final RxString type = ''.obs;
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    onProgressList.bindStream(getOnProgressList());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  Stream<List<OnProgressMAModel>> getOnProgressList() {
    log.i('On Progress MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isApproved', isEqualTo: true)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return OnProgressMAModel.fromJson(item.data());
      }).toList();
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  void refresh() {
    filteredList.clear();
    filteredList.assignAll(onProgressList);
  }

  void filter({required String type}) {
    filteredList.clear();

    //filter for type only
    if (type != '' && type != 'All') {
      for (var i = 0; i < onProgressList.length; i++) {
        if (onProgressList[i].type == type) {
          filteredList.add(onProgressList[i]);
        }
      }
    } else {
      filteredList.assignAll(onProgressList);
    }
  }

  void goBack() {
    return navigationController.navigatorKey.currentState!.pop();
  }

  Future<void> toBeReleased(String maID, String requesterID) async {
    showLoading();
    await firestore.collection('on_progress_ma').doc(maID).update({
      'isMedReady': true,
      'isApproved': false,
      'medWorth': worthController.text,
      'pharmacy': pharmacyController.text
    }).then((value) {
      sendNotification(requesterID);
      dismissDialog();
      dismissDialog();
      worthController.clear();
      pharmacyController.clear();
      goBack();
    }).catchError((onError) {
      dismissDialog();
      dismissDialog();
      showErrorDialog(
          errorTitle: 'Something went wrong',
          errorDescription: 'Unable to update request. Please try again later');
    });
  }

  Future<void> toBeReleasedFromList(
      String maID, String requesterID, GlobalKey<FormState> fKey) async {
    showLoading();
    await firestore.collection('on_progress_ma').doc(maID).update({
      'isMedReady': true,
      'isApproved': false,
      'medWorth': worthController.text,
      'pharmacy': pharmacyController.text
    }).then((value) {
      sendNotification(requesterID);
      dismissDialog();
      dismissDialog();
      fKey.currentState!.reset();
      worthController.clear();
      pharmacyController.clear();
      //goBack();
    }).catchError((onError) {
      dismissDialog();
      dismissDialog();
      showErrorDialog(
          errorTitle: 'Something went wrong',
          errorDescription: 'Unable to update request. Please try again later');
    });
  }

  Future<void> sendNotification(String uid) async {
    final action = ' is ready ';
    final title = 'MA${action}to be claimed';
    final message = 'You can now claim your MA in the PSWD Office';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': maLogoURL,
      'from': 'The PSWD Staff',
      'action': ' is informing you that your ',
      'subject': 'Medical Assistance is ready',
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
