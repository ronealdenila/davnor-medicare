import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegistrationController extends GetxController {
  final log = getLogger('Doctor Registration Controller');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController clinicHours = TextEditingController();

  final RxString title = ''.obs;
  final RxString department = ''.obs;

  Future<void> registerDoctor() async {
    if (formKey.currentState!.validate()) {
      final app = await Firebase.initializeApp(
          name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: '123456',
      )
          .then((result) async {
        final _userId = result.user!.uid;
        await _createDoctorUser(_userId);
      });

      await app.delete();
    }
  }

  Future<void> _createDoctorUser(String userID) async {
    log.i('Saving doctor data on id: $userID');
    await firestore.collection('users').doc(userID).set(<String, dynamic>{
      'userType': 'doctor',
    });
    await firestore.collection('doctors').doc(userID).set(
      <String, dynamic>{
        'categoryID': fetchCategories(), //TO CHECK
        'userID': userID,
        'email': emailController.text.trim(),
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'title': title.value,
        'department': department.value,
        'clinicHours': clinicHours.text,
        'profileImage': '',
        'disabled': false
      },
    ).then((value) => addDoctorStatus(userID));
    _clearControllers();
  }

  Future<String> fetchCategories() async {
    await firestore
        .collection('cons_status')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['title'] as String == title.value &&
            doc['title'] as String == department.value) {
          return doc['categoryID'];
        }
      });
    });
    return 'nullFetchingCategoryID';
  }

  Future<void> addDoctorStatus(String userID) async {
    await firestore
        .collection('doctors')
        .doc(userID)
        .collection('status')
        .doc('value')
        .set({
      'accomodated': 0,
      'numToAccomodate': 0,
      'overall': 0,
      'dStatus': false,
      'hasOngoingCons': false,
    });
  }

  void _clearControllers() {
    log.i('_clearControllers | User Input cleared');
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }
}
