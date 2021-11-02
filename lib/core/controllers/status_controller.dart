import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/patient_doc_status_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final log = getLogger('Status Controller');
  RxBool isLoading = true.obs;
  RxList<PatientStatusModel> patientStatus = RxList<PatientStatusModel>([]);

  @override
  void onReady() {
    super.onReady();
    patientStatus.bindStream(getPStatus());
  }

  //FOR QUEUE
  Stream<List<PatientStatusModel>> getPStatus() {
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return PatientStatusModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<DocumentSnapshot> getPatientStatus(String userID) {
    final Stream<DocumentSnapshot> doc = firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .snapshots();
    return doc;
  }

  Stream<DocumentSnapshot> getDoctorStatus(String userID) {
    final Stream<DocumentSnapshot> doc = firestore
        .collection('doctors')
        .doc(userID)
        .collection('status')
        .doc('value')
        .snapshots();
    return doc;
  }
}
