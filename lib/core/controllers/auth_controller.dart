import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:flutter/foundation.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  final log = getLogger('Auth Controller');

  Logger logger = Logger();

  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<PatientModel> patientModel = Rxn<PatientModel>();
  Rxn<DoctorModel> doctorModel = Rxn<DoctorModel>();
  Rxn<AdminModel> adminModel = Rxn<AdminModel>();
  Rxn<PswdModel> pswdModel = Rxn<PswdModel>();

  late Rx<User?> _firebaseUser;
  String? userRole;
  bool? userSignedOut = false;

  @override
  void onReady() {
    //signOut(); //For Signout sa user na nag error (i.e., patient)
    log.i('onReady | App is ready');
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  Future<void> _setInitialScreen(User? user) async {
    if (user == null) {
      log.i('_setInitialScreen | User is null. Proceed Signin Screen');
      if (userSignedOut == true) {
        await Get.offAll(() => LoginScreen());
      } else {
        navigateWithDelay('/login');
      }
    } else {
      userSignedOut = false;
      log.i('_setInitialScreen | User found. Data $user');
      await getUserRole(user.uid);
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      showLoading();
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      _clearControllers();
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
              email: emailController.text, password: passwordController.text)
          .then(
        (result) {
          final _userID = result.user!.uid;
          _createPatientUser(_userID);
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
      log.i(
          'sendPasswordResetEmail | Request password sent to email ${emailController.text}');
      Get.snackbar('Password Reset Email Sent',
          'Check your email and follow the instructions to reset your password.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
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
    await _db.collection('users').doc(_userID).set(<String, dynamic>{
      'userType': 'patient',
    });
    await _db.collection('patients').doc(_userID).set(<String, dynamic>{
      'email': emailController.text,
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'hasActiveQueue': false,
      'pStatus': false,
      'profileImage': '',
      'validID': '',
      'userType': 'patient',
    });
  }

  //check user type of logged in user and navigate
  Future<void> getUserRole(String currentUserUid) async {
    await _db.collection('users').doc(currentUserUid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userRole = documentSnapshot['userType'] as String;
          log.i('getUserRole | The current user has user role of $userRole');
        }
      },
    );
    await checkUserPlatform(currentUserUid);
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

  Future<void> checkUserPlatform(String uid) async {
    log.i('checkUserPlatform | is user logged on web: $kIsWeb');
    if (userSignedOut == false) {
      switch (userRole) {
        case 'pswd-p':
          await _initializePSWDModel(uid);
          await checkAppRestriction('/PSWDPersonnelHome');
          break;
        case 'pswd-h':
          await _initializePSWDModel(uid);
          await checkAppRestriction('/PSWDHeadHome');
          break;
        case 'admin':
          await _initializeAdminModel(uid);
          await checkAppRestriction('/AdminHome');
          break;
        case 'doctor':
          await _initializeDoctorModel(uid);
          navigateWithDelay('/DoctorHome');
          break;
        case 'patient':
          await _initializePatientModel(uid);
          navigateWithDelay('/PatientHome');
          break;
        default:
          print('Error Occured'); //TODO: Error Dialog or SnackBar
      }
    }
  }

  //Restrict admin and pswd from logging in mobile app
  Future<void> checkAppRestriction(String route) async {
    if (!kIsWeb) {
      await Get.defaultDialog(
        title: 'Sign In failed. Try Again',
        middleText:
            '$userRole is not authorized to log in at mobile platform. Please log in on Web Application',
        textConfirm: 'Okay',
        onConfirm: signOut,
      );
    } else {
      navigateWithDelay(route);
    }
  }

  void navigateWithDelay(String route) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(route);
    });
  }

  //initializedBaseOnUserRoles
  Future<void> _initializePatientModel(String userId) async {
    log.i('_initializeUserModelBasedOnRole | $userId has role $userRole');
    patientModel.value =
        await _db.collection('patients').doc(userId).get().then((doc) {
      //kini neal, document snapshot does not exist huhu (E)
      PatientModel.fromSnapshot(doc);
    });
    log.i(patientModel.value!.firstName);
  }

  Future<void> _initializeDoctorModel(String userId) async {
    log.i('_initializeUserModelBasedOnRole | $userId has role $userRole');
    doctorModel.value = await _db
        .collection('doctors')
        .doc(userId)
        .get()
        .then((doc) => DoctorModel.fromSnapshot(doc));
    log.i('Fetched Data: ${doctorModel.value!.firstName}');
  }

  Future<void> _initializePSWDModel(String userId) async {
    log.i('_initializeUserModelBasedOnRole | $userId has role $userRole');
    pswdModel.value = await _db
        .collection('pswd_personnel')
        .doc(userId)
        .get()
        .then((doc) => PswdModel.fromSnapshot(doc));
  }

  Future<void> _initializeAdminModel(String userId) async {
    log.i('_initializeUserModelBasedOnRole | $userId has role $userRole');
    adminModel.value = await _db
        .collection('admins')
        .doc(userId)
        .get()
        .then((doc) => AdminModel.fromSnapshot(doc));
    log.i(adminModel.value!.firstName);
  }
}
