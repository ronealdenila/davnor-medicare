import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AcceptedMAController extends GetxController {
  final log = getLogger('Accepted MA Controller');
  RxList<OnProgressMAModel> accMA = RxList<OnProgressMAModel>([]);
  RxInt index = (-1).obs;
  RxBool isLoading = true.obs;
  RxInt indexOfLive = (-1).obs;
  final NavigationController navigationController = Get.find();
  final MenuController menuController = Get.find();

  @override
  void onReady() {
    super.onReady();
    accMA.bindStream(getAcceptedMA());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
    ever(accMA, (value) {
      checkIfPersonnelHasAccepted();
    });
  }

  Stream<List<OnProgressMAModel>> getAcceptedMA() {
    log.i('Accepted MA Controller | get Accepted MA');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isAccepted', isEqualTo: true)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return OnProgressMAModel.fromJson(item.data());
      }).toList();
    });
  }

  void goBack() {
    return navigationController.navigatorKey.currentState!.pop();
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getPatientData(OnProgressMAModel model) async {
    model.requester.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  void checkIfPersonnelHasAccepted() {
    for (int i = 0; i < accMA.length; i++) {
      if (accMA[i].receiverID == auth.currentUser!.uid) {
        indexOfLive.value = i;
      }
    }
    indexOfLive.value - 1;
  }

  String getProfilePhoto(OnProgressMAModel model) {
    return model.requester.value!.profileImage!;
  }

  String getFirstName(OnProgressMAModel model) {
    return model.requester.value!.firstName!;
  }

  String getLastName(OnProgressMAModel model) {
    return model.requester.value!.lastName!;
  }

  String getFullName(OnProgressMAModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }

  Future<void> transferToHead(GeneralMARequestModel model) async {
    showLoading();
    await firestore.collection('on_progress_ma').doc(model.maID).update({
      'isAccepted': false,
      'isTransferred': true,
    }).then((value) async {
      await deleteMAFromQueue(model.maID!);
      await updatePatientStatus(model.requesterID!);
      dismissDialog();
      showDefaultDialog(
          dialogTitle: 'Transferred',
          dialogCaption: 'Successfully transfered to PSWD Program Head',
          onConfirmTap: () {
            dismissDialog();
            menuController.changeActiveItemTo('MA Request');
            navigationController.navigateTo(Routes.MA_REQ_LIST);
          });
    }).catchError((onError) {
      showErrorDialog(
          errorTitle: 'ERROR', errorDescription: 'Something went wrong');
    });
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
}
