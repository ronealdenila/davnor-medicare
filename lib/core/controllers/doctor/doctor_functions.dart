import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:get/get.dart';

class DoctorFunctions {
  final ConsultationsController consRequests = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final AppController appController = Get.find();

  Future<void> updateSlot(int toLess) async {
    dynamic currentSlot = 0;
    await firestore
        .collection('cons_status')
        .doc(fetchedData!.categoryID!)
        .update({
      'consSlot': toLess == 0 ? 0 : FieldValue.increment((toLess * (-1)))
    }).then((value) async {
      int currentLength = consRequests.consultations.length;

      await firestore
          .collection('cons_status')
          .doc(fetchedData!.categoryID!)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          Map data = documentSnapshot.data() as Map;
          currentSlot = data['consSlot']; //getDocu
          print('CURRENT SLOT: $currentSlot');
        }
      });

      if (currentLength > currentSlot) {
        for (int i = currentSlot; i < currentLength; i++) {
          await removeConsultations(consRequests.consultations[i].consID!,
              consRequests.consultations[i].patientId!);
        }
      }
    });
  }

  Future<void> removeConsultations(String consID, String patientID) async {
    showLoading();
    await deleteConsFromQueue(consID);
    await updatePatientStatus(patientID);
    await deleteConsFromReq(consID);
    await sendNotification(patientID);
    dismissDialog(); //dismissLoading
  }

  Future<void> deleteConsFromReq(String consID) async {
    await firestore
        .collection('cons_request')
        .doc(consID)
        .delete()
        .then((value) => print("Consultation Deleted"))
        .catchError((error) => print("Failed to delete consultation"));
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

  Future<void> sendNotification(String uid) async {
    final title = 'The doctor is offline';
    final message =
        "We are sorry to inform you that your consultation request has been removed due to the doctor's sudden unavailability";

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': appLogoURL,
      'from': 'DavNor MediCare Application',
      'action': ' has deleted your ',
      'subject': 'Consultation Request',
      'message': message,
      'createdAt': Timestamp.fromDate(DateTime.now()),
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
