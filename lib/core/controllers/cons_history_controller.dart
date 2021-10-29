import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConsHistoryController extends GetxController {
  final log = getLogger('Consultation History Controller');

  RxList<ConsultationHistoryModel> consHistory =
      RxList<ConsultationHistoryModel>([]);
  RxList<ChatModel> chatHistory = RxList<ChatModel>([]);

  Future<void> getConsHistoryForPatient() async {
    log.i('Get Cons History for Patient - ${auth.currentUser!.uid}');
    await firestore
        .collection('cons_history')
        .where('patientId', isEqualTo: auth.currentUser!.uid)
        //.orderBy('dateConsEnd', descending: true)
        .get()
        .then((value) {
      for (final result in value.docs) {
        consHistory.add(ConsultationHistoryModel.fromJson(result.data()));
      }
    });
  }

  Future<void> getConsHistoryForDoctor() async {
    log.i('Get Cons History for Doctor - ${auth.currentUser!.uid}');
    await firestore
        .collection('cons_history')
        .where('docID', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      for (final result in value.docs) {
        consHistory.add(ConsultationHistoryModel.fromJson(result.data()));
      }
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

  String getPatientName(ConsultationHistoryModel model) {
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

  String convertDate(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getChatHistory(ConsultationHistoryModel model) async {
    log.i(model.consID);
    await firestore
        .collection('chat')
        .doc(model.consID)
        .collection('messages')
        .orderBy('dateCreated', descending: true)
        .get()
        .then((value) {
      for (final result in value.docs) {
        chatHistory.add(ChatModel.fromJson(result.data()));
      }
    });
  }
}
