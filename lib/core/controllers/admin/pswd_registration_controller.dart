import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDRegistrationController extends GetxController {
  final log = getLogger('PSWD Registration Controller');
  final AdminMenuController menuController = Get.find();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final RxString position = ''.obs;

  Future<void> registerPSWD() async {
    showLoading();
    final app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
    await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: '123456',
    )
        .then((result) async {
      await _createPSWDUser(result.user!.uid);
      await app.delete();
    });
  }

  Future<void> _createPSWDUser(String userID) async {
    log.i('Saving pswd data on id: $userID');
    await firestore.collection('users').doc(userID).set(<String, dynamic>{
      'userType': position.value == 'Head' ? 'pswd-h' : 'pswd-p',
      'disabled': false
    });

    await firestore.collection('pswd_personnel').doc(userID).set(
      <String, dynamic>{
        'userID': userID,
        'email': emailController.text.trim(),
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'position': position.value,
        'profileImage': '',
        'disabled': false
      },
    ).then((value) {
      dismissDialog();
      Get.defaultDialog(
          title: 'PSWD Staff is successfully registered',
          middleText: "Default password has been assign to the staff's account",
          onConfirm: navigateToList);
    }).catchError((onError) {
      dismissDialog();
      Get.defaultDialog(title: 'Something went wrong');
    });

    _clearControllers();
  }

  void _clearControllers() {
    log.i('_clearControllers | User Input cleared');
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  void navigateToList() {
    dismissDialog();
    menuController.changeActiveItemTo('List of PSWD Personnel');
    navigationController.navigateTo(Routes.PSWD_STAFF_LIST);
  }
}
