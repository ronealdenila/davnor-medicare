import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/ui/screens/global/authentication.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/login.dart';
import 'package:flutter/foundation.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/home.dart';
import 'package:davnor_medicare/ui/screens/pswd_h/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
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
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      print('Send to signin');
      Get.offAll(() => AuthenticationScreen());
    } else {
      await _initializeUserModel(user.uid);
      _clearControllers();
      await getUserRole(user.uid);
    }
  }

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  registerWithEmailAndPassword(BuildContext context) async {
    try {
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
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
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

  //TODO(R): Refactor related to firestore requests and put into services folder named firestore_service
  //check user type of logged in user and navigate
  getUserRole(String currentUserUid) async {
    await _db.collection('users').doc(currentUserUid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userRole = documentSnapshot['userType'];
          print('The current user $currentUserUid has user type of $userRole');
        }
      },
    );
    await checkUserPlatform();
  }

  _initializeUserModel(String userID) async {
    userModel.value = await _db
        .collection('users')
        .doc(userID)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _clearControllers() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  checkUserPlatform() {
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
          Get.offAll(() => PatientHomeScreen());
          break;
        default:
          print('Error Occured'); //TODO: Error Dialog or SnackBar
      }
    } else {
      //Mobile Platform
      if (userRole == 'pswd-p' || userRole == 'pswd-h' || userRole == 'admin') {
        print(
            'Please log in on Web Application'); //TODO: Error Dialog or SnackBar
      } else {
        switch (userRole) {
          case 'doctor':
            Get.offAll(() => DoctorHomeScreen());
            break;
          case 'patient':
            Get.offAll(() => PatientHomeScreen());
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog or SnackBar
        }
      }
    }
  }
}
