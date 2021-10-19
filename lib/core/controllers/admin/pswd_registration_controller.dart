import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDRegistrationController extends GetxController {
  final log = getLogger('PSWD Registration Controller');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final RxString position = ''.obs;

  Future<void> registerPSWD() async {
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
        await _createPSWDUser(_userId);
      });

      await app.delete();

      // await auth
      //     .createUserWithEmailAndPassword(
      //   email: emailController.text,
      //   password: '123456',
      // )
      //     .then(
      //   (result) async {
      //     final _userID = result.user!.uid;
      //     await _createPSWDUser(_userID);
      //   },
      // );
    }
  }

  Future<void> _createPSWDUser(String userID) async {
    log.i('Saving doctor data on id: $userID');
    await firestore.collection('pswd_personnel').doc(userID).set(
      <String, dynamic>{
        'email': emailController.text.trim(),
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'position': position.value,
        'profileImage': null,
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
