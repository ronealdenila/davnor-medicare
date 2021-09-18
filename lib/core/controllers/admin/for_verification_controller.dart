import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:intl/intl.dart';

class ForVerificationController extends GetxController {
  final log = getLogger('Admin Verification Request Controller');

  RxList<VerificationReqModel> verifReq = RxList<VerificationReqModel>();

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
}
