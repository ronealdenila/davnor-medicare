import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConsultationsController extends GetxController {
  final log = getLogger('Doctor Home Consultations Controller');

  static AppController appController = Get.find();
  RxList<ConsultationModel> consultations = RxList<ConsultationModel>([]);
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  RxBool isLoading = true.obs;
  RxBool isLoadingPatientData = true.obs;
  final RxInt selectedIndex = 0.obs;
  final RxInt mobileIndex = 0.obs;

  @override
  void onReady() {
    super.onReady();
    consultations.bindStream(getConsultations());
  }

  Stream<List<ConsultationModel>> getConsultations() {
    log.i('getConsultations | Streaming Consultation Request');
    return firestore
        .collection('cons_request')
        .where('category', isEqualTo: fetchedData!.categoryID)
        .orderBy('dateRqstd')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return ConsultationModel.fromJson(item.data());
      }).toList();
    });
  }

  Future<void> startConsultation(ConsultationModel consData) async {
    showLoading();
    await addChatCollection(consData);
    await moveToLive(consData);
    await sendNotification(consData.patientId!);
    await updateDocStatus();
    dismissDialog();
    if (kIsWeb) {
      //TO DO: after starting cons go to hashboard navPop
    } else {
      Get.back();
    }
  }

  Future<void> addChatCollection(ConsultationModel consData) async {
    await sendMessage(
        consData.consID!, consData.patientId!, consData.description!);
    if (consData.imgs != '') {
      await sendMessage(consData.consID!, consData.patientId!, consData.imgs!);
    }
  }

  Future<void> sendMessage(String consID, String patientID, String msg) async {
    await firestore.collection('chat').doc(consID).collection('messages').add({
      'senderID': patientID,
      'message': msg,
      'dateCreated': FieldValue.serverTimestamp(), //Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> moveToLive(ConsultationModel consData) async {
    await firestore
        .collection('live_cons')
        .doc(consData.consID)
        .set(<String, dynamic>{
      'consID': consData.consID,
      'patientID': consData.patientId,
      'docID': fetchedData!.userID!,
      'fullName': consData.fullName,
      'age': consData.age,
      'dateRqstd': consData.dateRqstd,
      'dateConsStart': FieldValue.serverTimestamp(), //Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      await deleteConsFromReq(consData.consID!);
    });
  }

  Future<void> deleteConsFromReq(String consID) async {
    await firestore
        .collection('cons_request')
        .doc(consID)
        .delete()
        .then((value) => print("Consultation Deleted"))
        .catchError((error) => print("Failed to delete consultation"));
  }

  Future<void> updateDocStatus() async {
    await firestore
        .collection('doctors')
        .doc(fetchedData!.userID!)
        .collection('status')
        .doc('value')
        .update({'hasOngoingCons': true});
  }

  Future<void> getPatientData(ConsultationModel model) async {
    model.data.value = await firestore
        .collection('patients')
        .doc(model.patientId)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
    isLoadingPatientData.value = false;
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

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> sendNotification(String uid) async {
    final docName = fetchedData!.lastName;
    final action = ' has accepted your ';
    final title = 'Dr. ${docName}${action}Consultation Request';
    final message =
        'Please standby and get ready for the consultation through video call';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': fetchedData!.profileImage,
      'from': 'Dr. ${docName}',
      'action': action,
      'subject': 'Consultation Request Accepted',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(), //Timestamp.fromDate(DateTime.now()),
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
}


  // Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
  //   log.i('Doctor Consultations Controller | get Collection');
  //   return firestore
  //       .collection('cons_request')
  //       .where('category', isEqualTo: fetchedData!.categoryID)
  //       .orderBy('dateRqstd')
  //       .snapshots();
  // }

  // Stream<List<ConsultationModel>> assignListStream() {
  //   log.i('Doctor Consultations Controller | assign');
  //   return getCollection().map(
  //     (query) => query.docs
  //         .map((item) => ConsultationModel.fromJson(item.data()))
  //         .toList(),
  //   );
  // }