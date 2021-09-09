import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VerificationRequestController extends GetxController {
  final log = getLogger('Admin Verification Request Controller');

  RxList<VerificationReqModel> verifReq = RxList<VerificationReqModel>();

  @override
  void onReady() {
    super.onReady();
    verifReq.bindStream(getVfRequestList());
  }

  Stream<List<VerificationReqModel>> getVfRequestList() {
    log.i('Admin Verification Request Controller | getVfRequestList');
    return firestore
        .collection('to_verify')
        .orderBy('dateRqstd', descending: false)
        .snapshots()
        .map(
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

  String getProfilePhoto(int index) {
    return verifReq[index].data.value!.profileImage!;
  }

  String getFirstNamebyIndex(int index) {
    return verifReq[index].data.value!.firstName!;
  }

  String getLastNamebyIndex(int index) {
    return verifReq[index].data.value!.lastName!;
  }

  String getValidID(int index) {
    return verifReq[index].validID!;
  }

  String getValidIDWithSelfie(int index) {
    return verifReq[index].validSelfie!;
  }

  String getDateTime(int index) {
    final temp = verifReq[index].dateRqstd;
    return convertTimeStamp(temp!);
  }
}
