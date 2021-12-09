import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegistrationController extends GetxController {
  final log = getLogger('Doctor Registration Controller');
  final AdminMenuController menuController = Get.find();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController clinicHours = TextEditingController();
  final DoctorListController dListController = Get.find();

  final RxString title = ''.obs;
  final RxString department = ''.obs;
  final RxString categoryID = ''.obs;
  final RxBool doneFetch = false.obs;

  Future<void> registerDoctor() async {
    showLoading();
    categoryID.value = '';
    await fetchCategories();
    if (categoryID.value == '') {
      dismissDialog();
      showErrorDialog(
          errorTitle: 'Something went wrong',
          errorDescription:
              'Could not find the right category ID for this type of doctor.');
    } else {
      print(categoryID.value);
      final app = await Firebase.initializeApp(
          name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: '123456',
      )
          .then((result) async {
        await _createDoctorUser(result.user!.uid);
        await app.delete();
      });
    }
  }

  Future<void> _createDoctorUser(String userID) async {
    log.i('Saving doctor data on id: $userID');
    await firestore
        .collection('users')
        .doc(userID)
        .set(<String, dynamic>{'userType': 'doctor', 'disabled': false});
    await firestore.collection('doctors').doc(userID).set(
      <String, dynamic>{
        'categoryID': categoryID.value,
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
    ).then((value) {
      addDoctorStatus(userID);
      dismissDialog();
      Get.defaultDialog(
          title: 'Doctor is successfully registered',
          middleText:
              "Default password has been assign to the doctor's account",
          onConfirm: navigateToList);
    }).catchError((onError) {
      dismissDialog();
      showSimpleErrorDialog(
          errorDescription: 'Something went wrong. Could not register doctor');
    });
    _clearControllers();
  }

  Future<void> fetchCategories() async {
    await firestore
        .collection('cons_status')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc['title'] as String == title.value &&
            doc['deptName'] as String == department.value) {
          categoryID.value = doc['categoryID'];
          return;
        }
      });
    });
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

  Future<void> navigateToList() async {
    dismissDialog();
    await dListController.refetchList();
    menuController.changeActiveItemTo('List Of Doctors');
    navigationController.navigateTo(Routes.DOCTOR_LIST);
  }
}
