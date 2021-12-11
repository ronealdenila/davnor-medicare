import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ForVerificationController extends GetxController {
  final log = getLogger('Admin Verification Request Controller');
  static AuthController authController = Get.find();
  static AppController appController = Get.find();
  final fetchedData = authController.adminModel.value;
  RxList<VerificationReqModel> verifReq = RxList<VerificationReqModel>();
  TextEditingController reason = TextEditingController();
  RxBool accepted = false.obs;
  final NavigationController navigationController = Get.find();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    verifReq.bindStream(assignListStream());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  Stream<List<VerificationReqModel>> assignListStream() {
    log.i('Admin Verification Request Controller | getList');
    return firestore
        .collection('to_verify')
        .orderBy('dateRqstd')
        .snapshots(includeMetadataChanges: true)
        .map((query) {
      return query.docs.map((item) {
        return VerificationReqModel.fromJson(item.data());
      }).toList();
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getPatientData(VerificationReqModel model) async {
    model.data.value = await firestore
        .collection('patients')
        .doc(model.patientID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getFirstName(VerificationReqModel model) {
    return model.data.value!.firstName!;
  }

  String getLastName(VerificationReqModel model) {
    return model.data.value!.lastName!;
  }

  String getFullName(VerificationReqModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }

  String getProfilePhoto(VerificationReqModel model) {
    return model.data.value!.profileImage!;
  }

  String getValidID(VerificationReqModel model) {
    return model.validID!;
  }

  String getValidIDWithSelfie(VerificationReqModel model) {
    return model.validSelfie!;
  }

  String getDateTime(VerificationReqModel model) {
    final temp = model.dateRqstd;
    return convertTimeStamp(temp!);
  }

  Future<void> transferPhotos(VerificationReqModel model) async {
    await firestore.collection('patients').doc(model.patientID).update({
      'validID': model.validID,
      'validSelfie': model.validSelfie,
    });
  }

  Future<void> deletePhotos(VerificationReqModel model) async {
    await storage.refFromURL(model.validID!).delete();
    await storage.refFromURL(model.validSelfie!).delete();
  }

  Future<void> acceptUserVerification(VerificationReqModel model) async {
    showLoading();
    accepted.value = true;
    await firestore
        .collection('patients')
        .doc(model.patientID)
        .collection('status')
        .doc('value')
        .update({'pStatus': true, 'pendingVerification': false}).then(
            (value) async {
      await transferPhotos(model);
      await addNotification(model.patientID!);
      await removeVerificationReq(model.patientID!);
      await incrementVerifCount();
      dismissDialog();
      dismissDialog();
      navigationController.navigateTo(Routes.VERIFICATION_REQ_LIST);
      clearController();
    }).catchError((error) {
      dismissDialog();
      dismissDialog();
      Get.snackbar(
        'Failed to verified user',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future<void> incrementVerifCount() async {
    await firestore.collection('app_status').doc('verified_users').update({
      'count': FieldValue.increment(1),
    });
  }

  Future<void> desclineUserVerification(VerificationReqModel model) async {
    accepted.value = false;
    if (reason.text.isEmpty) {
      Get.snackbar(
        'Submit Failed',
        'Please make sure to add a reason',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    showLoading();
    await firestore
        .collection('patients')
        .doc(model.patientID)
        .collection('status')
        .doc('value')
        .update({'pendingVerification': false}).then((value) async {
      await addNotification(model.patientID!);
      await deletePhotos(model);
      await removeVerificationReq(model.patientID!);
      dismissDialog();
      dismissDialog();
      navigationController.navigateTo(Routes.VERIFICATION_REQ_LIST);
      clearController();
    }).catchError((error) {
      dismissDialog();
      dismissDialog();
      Get.snackbar(
        'Failed to decline user',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future<void> addNotification(String uid) async {
    final action = accepted.value ? ' has accepted your ' : ' has denied your ';
    final title = 'The admin${action}Verification Request';
    final message =
        accepted.value ? 'Your account now is verified' : '"${reason.text}"';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': appLogoURL,
      'from': 'The admin',
      'action': action,
      'subject': 'Verification Request',
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

  Future<void> removeVerificationReq(String uid) async {
    await firestore.collection('to_verify').doc(uid).delete();
  }

  void clearController() {
    log.i('_clearController | Reason Declined');
    reason.clear();
    accepted.value = false;
  }
}
