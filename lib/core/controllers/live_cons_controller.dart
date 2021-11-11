import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LiveConsController extends GetxController {
  final log = getLogger('Live Consultation Controller');
  static AppController appController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  RxList<LiveConsultationModel> liveCons = RxList<LiveConsultationModel>([]);
  TextEditingController reason = TextEditingController();
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    liveCons.bindStream(getLiveCons());
  }

  Stream<List<LiveConsultationModel>> getLiveCons() {
    log.i('Get Live Cons | ${auth.currentUser!.uid}');
    if (authController.userRole == 'doctor') {
      return firestore
          .collection('live_cons')
          .where('docID', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((query) {
        return query.docs.map((item) {
          isLoading.value = false;
          return LiveConsultationModel.fromJson(item.data());
        }).toList();
      });
    } else {
      return firestore
          .collection('live_cons')
          .where('patientID', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((query) {
        return query.docs.map((item) {
          isLoading.value = false;
          return LiveConsultationModel.fromJson(item.data());
        }).toList();
      });
    }
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

  Future<void> endConsultation(LiveConsultationModel model) async {
    showLoading();
    await firestore
        .collection('cons_history')
        .doc(model.consID)
        .set(<String, dynamic>{
      'consID': model.consID,
      'patientID': model.patientID,
      'docID': model.docID,
      'fullName': model.fullName,
      'age': model.age,
      'dateRqstd': model.dateRqstd,
      'dateConsStart': model.dateConsStart,
      'dateConsEnd': Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      //TO THINK - NOTIF TO SUCCESS/DONE CONSULTATION??
      await deleteConsFromQueue(model.consID!);
      await removeFromLive(model.consID!);
      await updateDocStatus(fetchedData!.userID!);
      await updatePatientStatus(model.patientID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      Get.back(); //back to Live Screen Info
      Get.back(); //
    });
  }

  Future<void> removeFromLive(String consID) async {
    await firestore
        .collection('live_cons')
        .doc(consID)
        .delete()
        .then((value) => print("Consultation Ended"))
        .catchError((error) => print("Failed to end consultation"));
  }

  Future<void> removeFromChat(String consID) async {
    await firestore
        .collection('chat')
        .doc(consID)
        .collection('messages')
        .doc(consID)
        .delete()
        .then((value) => print("Consultation Ended"))
        .catchError((error) => print("Failed to end consultation"));
  }

  Future<void> updateDocStatus(String docID) async {
    await firestore
        .collection('doctors')
        .doc(docID)
        .collection('status')
        .doc('value')
        .get()
        .then((DocumentSnapshot snap) async {
      final addedCount = snap['accomodated'] + 1;
      await firestore
          .collection('doctors')
          .doc(docID)
          .collection('status')
          .doc('value')
          .update({'hasOngoingCons': false, 'accomodated': addedCount});
    });
  }

  Future<void> updatePatientStatus(String patientID) async {
    await firestore
        .collection('patients')
        .doc(patientID)
        .collection('status')
        .doc('value')
        .update(
            {'hasActiveQueueCons': false, 'categoryID': '', 'queueCons': ''});
  }

  Future<void> deleteConsFromQueue(String consID) async {
    await firestore
        .collection('cons_queue')
        .doc(consID)
        .delete()
        .then((value) => print("Consultation  Deleted in Queue"))
        .catchError((error) => print("Failed to delete consultation in queue"));
  }

  Future<void> skipConsultation(String consID, String patientID) async {
    showLoading();
    await deleteConsFromQueue(consID);
    //TO DO - del storage folder
    await removeFromLive(consID);
    await removeFromChat(consID);
    await updatePatientStatus(patientID);
    await sendNotification(patientID);
    await updateDocStatusSkip(fetchedData!.userID!);
    dismissDialog(); //dismissLoading
    dismissDialog(); //then dismiss dialog for reason
    Get.back(); //back to Live Screen Info
    Get.back(); //back to Patient Home
  }

  Future<void> updateDocStatusSkip(String docID) async {
    await firestore
        .collection('doctors')
        .doc(docID)
        .collection('status')
        .doc('value')
        .update({'hasOngoingCons': false});
  }

  Future<void> sendNotification(String uid) async {
    final docName = fetchedData!.lastName;
    final action = ' has skipped your ';
    final title = 'Dr. ${docName}${action}Consultation Request';
    final message = '"${reason.text}"';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': fetchedData!.profileImage,
      'from': 'Dr. ${docName}',
      'action': action,
      'subject': 'Consultation Request Skipped',
      'message': message,
      'createdAt': Timestamp.fromDate(DateTime.now()),
    });

    await appController.sendNotificationViaFCM(title, message, uid);

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('status')
        .doc('value')
        .get()
        .then((doc) async {
      final count = int.parse(doc['notifBadge'] as String) + 1;
      await firestore
          .collection('patients')
          .doc(uid)
          .collection('status')
          .doc('value')
          .update({
        'notifBadge': '$count',
      });
    });
  }

  void deleteDirectory(String path) {
    final ref = storage.ref(path);
    ref.listAll().then((dir) {
      dir.items.forEach((fileRef) {
        this.deleteFile(ref.fullPath, fileRef.name);
      });
      dir.prefixes.forEach((folderRef) {
        this.deleteDirectory(folderRef.fullPath);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  deleteFile(pathToFile, fileName) {
    final ref = storage.ref(pathToFile);
    final childRef = ref.child(fileName);
    childRef.delete();
  }
}
