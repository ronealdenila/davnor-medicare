import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
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
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: '123456',
      )
          .then(
        (result) async {
          final _userID = result.user!.uid;
          await _createDoctorUser(_userID);
        },
      );
    }
  }

  Future<void> _createDoctorUser(String userID) async {
    log.i('Saving doctor data on id: $userID');
    await firestore.collection('doctors').doc(userID).set(
      <String, dynamic>{
        'email': emailController.text.trim(),
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'title': title.value,
        'department': department.value,
        'clinicHours': clinicHours.text,
        'numToAccomodate': 0,
        'profileImage': null,
        'dStatus': false,
        'hasOngoingCons': false,
      },
    );
    _clearControllers();
  }

  void _clearControllers() {
    log.i('_clearControllers | User Input cleared');
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }
}
