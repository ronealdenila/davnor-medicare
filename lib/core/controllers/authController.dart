import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/global/login.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/home.dart';
import 'package:flutter/foundation.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  final log = getLogger('Auth Controller');

  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<UserModel> userModel = UserModel().obs;
  late Rx<User?> _firebaseUser;
  String? userRole;

  @override
  void onReady() {
    log.i('onReady | App is ready');
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      log.i('_setInitialScreen | User is $user. Send to Signin Screen');
      Get.offAll(() => LoginScreen());
    } else {
      log.i('_setInitialScreen | User found. Data $user');
      await _initializeUserModel(user.uid);
      _clearControllers();
      await getUserRole(user.uid);
    }
  }

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      showLoading();
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      dismissDialog();
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  registerWithEmailAndPassword(BuildContext context) async {
    try {
      showLoading();
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
        (result) {
          String _userID = result.user!.uid;
          _createUserFirestore(_userID);
        },
      );
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
          'sendPasswordResetEmail | Request password reset success to email ${emailController.text}');
      Get.snackbar('Password Reset Email Sent',
          'Check your email and follow the instructions to reset your password.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on FirebaseAuthException catch (error) {
      Get.snackbar('Password Reset Email Failed', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void _createUserFirestore(String _userID) async {
    await _db.collection('users').doc(_userID).set({
      "uid": _userID,
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "hasActiveQueue": false,
      "pStatus": false,
      "profileImage": "",
      "validID": "",
      "userType": 'patient',
    });
  }

  //check user type of logged in user and navigate
  getUserRole(String currentUserUid) async {
    await _db.collection('users').doc(currentUserUid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userRole = documentSnapshot['userType'];
          log.i('getUserRole | The current user has user role of $userRole');
        }
      },
    );
    await checkUserPlatform();
  }

  _initializeUserModel(String userID) async {
    log.i('_initializeUserModel | the userID fetched is $userID');
    userModel.value = await _db
        .collection('users')
        .doc(userID)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  signOut() async {
    try {
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

  _clearControllers() {
    log.i('_clearControllers | User Input on authentication is cleared');
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  checkUserPlatform() {
    log.i('checkUserPlatform | is user logged on web: $kIsWeb');
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          Get.offAll(() => PSWDPersonnelHomeScreen());
          break;
        case 'pswd-h':
          Get.offAll(() => PSWDHeadHomeScreen());
          break;
        case 'admin':
          Get.offAll(() => AdminHomeScreen());
          break;
        case 'doctor':
          Get.offAll(() => DoctorHomeScreen());
          break;
        case 'patient':
          log.i(
              'checkUserPlatform | user role is $userRole | redirecting to Patient Home Screen');
          Get.offAll(() => PatientHomeScreen());
          break;
        default:
          print('Error Occured'); //TODO: Error Dialog or SnackBar
      }
    } else {
      //Mobile Platform
      if (userRole == 'pswd-p' || userRole == 'pswd-h' || userRole == 'admin') {
        Get.defaultDialog(
          title: 'Sign In failed. Try Again',
          middleText:
              '$userRole is not authorized to log in at mobile platform. Please log in on Web Application',
          textConfirm: 'Okay',
          onConfirm: signOut,
        );
        log.w(
            'checkUserPlatform | user role is $userRole | Please log in on Web Application');
      } else {
        switch (userRole) {
          case 'doctor':
            Get.offAll(() => DoctorHomeScreen());
            break;
          case 'patient':
            log.i(
                'checkUserPlatform | user role is $userRole | redirecting to Patient Home Screen');
            Get.offAll(() => PatientHomeScreen());
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog or SnackBar
        }
      }
    }
  }
}
