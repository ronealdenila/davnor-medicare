import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/auth/login.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final log = getLogger('Auth Controller');

  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Rxn<PatientModel> patientModel = Rxn<PatientModel>();
  Rxn<DoctorModel> doctorModel = Rxn<DoctorModel>();
  Rxn<AdminModel> adminModel = Rxn<AdminModel>();
  Rxn<PswdModel> pswdModel = Rxn<PswdModel>();

  Rxn<User> firebaseUser = Rxn<User>();
  String? userRole;
  bool? userSignedOut = false;

  @override
  void onReady() {
    log.i('onReady | App is ready');
    // ever(firebaseUser, _setInitialScreen);

    // firebaseUser.bindStream(user);
    super.onReady();
  }

  Stream<User?> get user => _auth.authStateChanges();

  Future<void> _setInitialScreen(_firebaseUser) async {
    log.i('_setInitialScreen');
    if (_firebaseUser == null) {
      log.i('_setInitialScreen | User is null. Proceed Signin Screen');
      if (userSignedOut == true) {
        await Get.offAll(() => LoginScreen());
      } else {
        await navigateWithDelay(Get.offAll(() => LoginScreen()));
      }
    } else {
      userSignedOut = false;
      log.i('_setInitialScreen | User found. Data $_firebaseUser');
      await getUserRole();
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      showLoading();
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await _clearControllers();
    } catch (e) {
      dismissDialog();
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> registerPatient(BuildContext context) async {
    try {
      showLoading();
      await _auth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then(
        (result) async {
          final _userID = result.user!.uid;
          await _createPatientUser(_userID);
        },
      );
      await _clearControllers();
    } on FirebaseAuthException catch (e) {
      dismissDialog();
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      log.i('Password link sent to: ${emailController.text}');
      Get.snackbar('Password Reset Email Sent',
          'Check your email for a password reset link.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on FirebaseAuthException catch (error) {
      Get.snackbar('Password Reset Email Failed', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> _createPatientUser(String _userID) async {
    await firebaseFirestore
        .collection('users')
        .doc(_userID)
        .set(<String, dynamic>{
      'userType': 'patient',
    });
    await firebaseFirestore
        .collection('patients')
        .doc(_userID)
        .set(<String, dynamic>{
      'email': emailController.text.trim(),
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'hasActiveQueue': false,
      'pStatus': false,
      'profileImage': '',
      'validID': '',
      'validSelfie': '',
    });
  }

  //check user type of logged in user and navigate
  Future<void> getUserRole() async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseUser.value!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userRole = documentSnapshot['userType'] as String;
          log.i('getUserRole | The current user has user role of $userRole');
        }
      },
    );
    await checkUserPlatform();
  }

  Future<void> signOut() async {
    try {
      userSignedOut = true;
      await _auth.signOut();
      log.i('signOut | User signs out successfully');
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _clearControllers() async {
    log.i('_clearControllers | User Input on authentication is cleared');
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  Future<void> checkUserPlatform() async {
    log.i('checkUserPlatform | is user logged on web: $kIsWeb');
    if (userSignedOut == false) {
      switch (userRole) {
        case 'pswd-p':
          await _initializePSWDModel();
          await checkAppRestriction(userRole);
          break;
        case 'pswd-h':
          await _initializePSWDModel();
          await checkAppRestriction(userRole);
          break;
        case 'admin':
          await _initializeAdminModel();
          await checkAppRestriction(userRole);
          break;
        case 'doctor':
          await _initializeDoctorModel();
          await navigateWithDelay(Get.offAll(() => DoctorHomeScreen()));
          break;
        case 'patient':
          await _initializePatientModel();
          await navigateWithDelay(Get.offAll(() => PatientHomeScreen()));
          break;
        default:
          await Get.defaultDialog(title: 'Error Occured');
      }
    }
  }

  //Restrict admin and pswd from logging in mobile app
  Future<void> checkAppRestriction(String? userRole) async {
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          await navigateWithDelay(Get.offAll(() => PSWDPersonnelHomeScreen()));
          break;
        case 'pswd-h':
          await navigateWithDelay(Get.offAll(() => PSWDHeadHomeScreen()));
          break;
        case 'admin':
          await navigateWithDelay(Get.offAll(() => AdminHomeScreen()));
          break;
        default:
          await Get.defaultDialog(title: 'Error Occured');
      }
    } else {
      await Get.defaultDialog(
        title: 'Sign In failed. Try Again',
        middleText: checkAppRestrictionErrorMiddleText,
        textConfirm: 'Okay',
        onConfirm: signOut,
      );
    }
  }

  Future<void> navigateWithDelay(dynamic route) async {
    await Future.delayed(const Duration(seconds: 1), () => route);
  }

  //initializedBaseOnUserRoles
  Future<void> _initializePatientModel() async {
    log.i(
        '_initializePatientModel | ${firebaseUser.value!.uid} role: $userRole');
    patientModel.value = await firebaseFirestore
        .collection('patients')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  Future<void> _initializeDoctorModel() async {
    log.i(
        '_initializeDoctorModel | ${firebaseUser.value!.uid} role: $userRole');
    doctorModel.value = await firebaseFirestore
        .collection('doctors')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => DoctorModel.fromJson(doc.data()!));
  }

  Future<void> _initializePSWDModel() async {
    log.i('_initializePSWDModel | ${firebaseUser.value!.uid} role: $userRole');
    pswdModel.value = await firebaseFirestore
        .collection('pswd_personnel')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => PswdModel.fromJson(doc.data()!));
  }

  Future<void> _initializeAdminModel() async {
    log.i('_initializeAdminModel | ${firebaseUser.value!.uid} role: $userRole');
    adminModel.value = await firebaseFirestore
        .collection('admins')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => AdminModel.fromJson(doc.data()!));
  }
}
