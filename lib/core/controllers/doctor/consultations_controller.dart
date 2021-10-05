import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConsultationsController extends GetxController {
  final log = getLogger('Doctor Home Consultations Controller');

  RxList<ConsultationModel> consultations = RxList<ConsultationModel>([]);

  @override
  void onReady() {
    super.onReady();
    consultations.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
    log.i('Doctor Consultations Controller | get Collection');
    return firestore
        .collection('cons_request')
        .orderBy('dateRqstd')
        .where('category', isEqualTo: 'Heart')
        .snapshots();
  }
  //category is hard coded for now. must be initialized based on title of
  //logged in doctor

  Stream<List<ConsultationModel>> assignListStream() {
    log.i('Doctor Consultations Controller | assign');
    return getCollection().map(
      (query) => query.docs
          .map((item) => ConsultationModel.fromJson(item.data()))
          .toList(),
    );
  }

  Future<void> getPatientData(ConsultationModel model) async {
    model.data.value = await firestore
        .collection('patients')
        .doc(model.patientId)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getProfilePhoto(ConsultationModel model) {
    return model.data.value!.profileImage!;
  }

  String getFirstName(ConsultationModel model) {
    return model.data.value!.firstName!;
  }

  String getLastName(ConsultationModel model) {
    return model.data.value!.lastName!;
  }

  String getFullName(ConsultationModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }

  String convertEpoch(String date) {
    final dt = DateTime.fromMillisecondsSinceEpoch(1631271365106617 ~/ 1000);
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  // Stream<List<ConsultationModel>> getConsultations() {
  //   log.i('getConsultations | Streaming Consultation Request');
  //   return firestore
  //       .collection('cons_request')
  //       .orderBy('dateRqstd', descending: false)
  //       //category is hard coded for now. must be initialized based on title of
  //       //logged in doctor
  //       .where('category', isEqualTo: 'Heart')
  //       .snapshots()
  //       .map(
  //         (query) => query.docs
  //             .map((item) => ConsultationModel.fromJson(item.data()))
  //             .toList(),
  //       );
  // }
}
