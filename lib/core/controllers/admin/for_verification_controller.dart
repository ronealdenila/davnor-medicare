import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:intl/intl.dart';

class ForVerificationController extends GetxController {
  final log = getLogger('Admin Verification Request Controller');
  static AuthController authController = Get.find();
  final fetchedData = authController.adminModel.value;
  RxList<VerificationReqModel> verifReq = RxList<VerificationReqModel>();
  TextEditingController reason = TextEditingController();
  RxBool accepted = false.obs;

  @override
  void onReady() {
    super.onReady();
    verifReq.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
    log.i('Admin Verification Request Controller | getList');
    return firestore
        .collection('to_verify')
        .orderBy('dateRqstd', descending: false)
        .snapshots();
  }

  Stream<List<VerificationReqModel>> assignListStream() {
    log.i('Admin Verification Request Controller | assign');
    return getCollection().map(
      (query) => query.docs
          .map((item) => VerificationReqModel.fromJson(item.data()))
          .toList(),
    );
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

  Future<void> acceptUserVerification(String uid) async {
    showLoading();
    accepted.value = true;
    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .doc('value')
        .update({'pStatus': true, 'pendingVerification': false}).then((value) {
      removeVerificationReq(uid);
      Get.off(() => VerificationReqListScreen());
      addNotification(uid);
      clearController();
    }).catchError((error) {
      dismissDialog();
      Get.snackbar(
        'Failed to verified user',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future<void> desclineUserVerification(String uid) async {
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
        .doc(uid)
        .collection('notifications')
        .doc('value')
        .update({'pendingVerification': false}).then((value) {
      removeVerificationReq(uid);
      dismissDialog();
      Get.off(() => VerificationReqListScreen());
      addNotification(uid);
      clearController();
    }).catchError((error) {
      dismissDialog();
      Get.snackbar(
        'Failed to decline user',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future<void> addNotification(String uid) async {
    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': '',
      'from': 'The admin',
      'action': accepted.value ? ' has accepted your ' : ' has denied your ',
      'subject': 'Verification Request',
      'message':
          accepted.value ? 'Your account now is verified' : '"${reason.text}"',
      'createdAt': Timestamp.fromDate(DateTime.now()),
    });
    //SEND NOTIF TO DEVICE ALSO
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
