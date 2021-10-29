import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LiveConsController extends GetxController {
  final log = getLogger('Live Consultation Controller');

  static AuthController authController = Get.find();
  RxList<LiveConsultationModel> liveCons = RxList<LiveConsultationModel>([]);

  @override
  void onReady() {
    super.onReady();
    liveCons.bindStream(assignLiveCons());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLiveCons() {
    log.i('Get Live Cons | ${auth.currentUser!.uid}');
    if (authController.userRole == 'doctor') {
      return firestore
          .collection('live_cons')
          .where('docID', isEqualTo: auth.currentUser!.uid)
          .snapshots();
    }
    return firestore
        .collection('live_cons')
        .where('patientID', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Stream<List<LiveConsultationModel>> assignLiveCons() {
    log.i('Assign Live Cons');
    return getLiveCons().map(
      (query) => query.docs
          .map((item) => LiveConsultationModel.fromJson(item.data()))
          .toList(),
    );
  }

  Future<void> getPatientData(LiveConsultationModel model) async {
    model.patient.value = await firestore
        .collection('patients')
        .doc(model.patientID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  Future<void> getDoctorData(LiveConsultationModel model) async {
    model.doc.value = await firestore
        .collection('doctors')
        .doc(model.docID)
        .get()
        .then((doc) => DoctorModel.fromJson(doc.data()!));
  }

  String getPatientProfile(LiveConsultationModel model) {
    return model.patient.value!.profileImage!;
  }

  String getPatientFirstName(LiveConsultationModel model) {
    return model.patient.value!.firstName!;
  }

  String getPatientLastName(LiveConsultationModel model) {
    return model.patient.value!.lastName!;
  }

  String getPatientName(LiveConsultationModel model) {
    return '${getPatientFirstName(model)} ${getPatientLastName(model)}';
  }

  String getDoctorProfile(LiveConsultationModel model) {
    return model.doc.value!.profileImage!;
  }

  String getDoctorFirstName(LiveConsultationModel model) {
    return model.doc.value!.firstName!;
  }

  String getDoctorLastName(LiveConsultationModel model) {
    return model.doc.value!.lastName!;
  }

  String getDoctorFullName(LiveConsultationModel model) {
    return '${getDoctorFirstName(model)} ${getDoctorLastName(model)}';
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
