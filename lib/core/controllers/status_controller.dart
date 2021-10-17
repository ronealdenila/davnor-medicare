import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final log = getLogger('Status Controller');

  Stream<DocumentSnapshot> getPatientStatus(String userID) {
    final Stream<DocumentSnapshot> doc = firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .snapshots();
    return doc;
  }
}
