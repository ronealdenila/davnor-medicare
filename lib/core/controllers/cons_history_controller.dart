import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsHistoryController extends GetxController {
  final log = getLogger('Consultation History Controller');

  RxList<ConsultationHistoryModel> consHistory =
      RxList<ConsultationHistoryModel>([]);

  Future<void> getConsHistory() async {
    log.i('get Cons History');
    log.i(auth.currentUser!.uid);
    await firestore
        .collection('cons_history')
        .where('patientId', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        consHistory.add(ConsultationHistoryModel.fromJson(result.data()));
      });
    });
  }

  Future<void> getAdditionalData(ConsultationHistoryModel model) async {
    await getPatientData(model);
    await getDoctorData(model);
  }

  Future<void> getPatientData(ConsultationHistoryModel model) async {
    model.patient.value = await firestore
        .collection('patients')
        .doc(model.patientId)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  Future<void> getDoctorData(ConsultationHistoryModel model) async {
    model.doc.value = await firestore
        .collection('doctors')
        .doc(model.docID)
        .get()
        .then((doc) => DoctorModel.fromJson(doc.data()!));
  }

  String getPatientProfile(ConsultationHistoryModel model) {
    return model.patient.value!.profileImage!;
  }

  String getPatientFirstName(ConsultationHistoryModel model) {
    return model.patient.value!.firstName!;
  }

  String getPatientLastName(ConsultationHistoryModel model) {
    return model.patient.value!.lastName!;
  }

  String getPatientFullName(ConsultationHistoryModel model) {
    return '${getPatientFirstName(model)} ${getPatientLastName(model)}';
  }

  String getDoctorProfile(ConsultationHistoryModel model) {
    return model.doc.value!.profileImage!;
  }

  String getDoctorFirstName(ConsultationHistoryModel model) {
    return model.doc.value!.firstName!;
  }

  String getDoctorLastName(ConsultationHistoryModel model) {
    return model.doc.value!.lastName!;
  }

  String getDoctorFullName(ConsultationHistoryModel model) {
    return '${getDoctorFirstName(model)} ${getDoctorLastName(model)}';
  }
}
