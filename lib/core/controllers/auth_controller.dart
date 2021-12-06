import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/auth/login.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final log = getLogger('Auth Controller');
  final AppController appController = Get.put(AppController());
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Rxn<PatientModel> patientModel = Rxn<PatientModel>();
  Rxn<DoctorModel> doctorModel = Rxn<DoctorModel>();
  Rxn<AdminModel> adminModel = Rxn<AdminModel>();
  Rxn<PswdModel> pswdModel = Rxn<PswdModel>();

  Rxn<User> firebaseUser = Rxn<User>();

  String? userRole;
  bool? userSignedOut = false;
  RxBool? isObscureText = true.obs;
  RxBool? isObscureText2 = true.obs;
  RxBool? isObscureCurrentPW = true.obs;
  RxBool? isObscureNewPW = true.obs;
  RxBool isCheckboxChecked = false.obs;
  RxString tokenID = ''.obs;

  RxBool doneInitData = false.obs;
  //Doctor Application Guide
  static const emailScheme = doctorapplicationinstructionParagraph0;
  static const formUrl = 'https://forms.gle/WKWnBsG9EuivmY1dA';

  @override
  void onReady() {
    log.i('onReady | Auth Controller is ready');
    ever(firebaseUser, _setInitialScreen);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  Stream<User?> get user => auth.idTokenChanges();

  Future<void> _setInitialScreen(_firebaseUser) async {
    if (_firebaseUser == null) {
      log.i('_setInitialScreen | User is null. Proceed Signin Screen');
      if (userSignedOut == true) {
        await Get.offAll(() => LoginScreen());
      } else {
        await Future.delayed(
            const Duration(seconds: 5), () => Get.offAll(() => LoginScreen()));
      }
    } else {
      userSignedOut = false;
      log.i('_setInitialScreen | User found. Data: ${_firebaseUser.email}');
      await getUserRole();
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    FocusScope.of(context).unfocus();

    try {
      showLoading();
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await clearControllers();
    } catch (e) {
      print(e);
      dismissDialog();
      Get.snackbar(
        'Error logging in',
        'Please check your email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> registerPatient(BuildContext context) async {
    FocusScope.of(context).unfocus();
    showLoading();
    final app = await Firebase.initializeApp(
        name: 'tempApp', options: Firebase.app().options);
    await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((result) async {
      await _createPatientUser(result.user!.uid, context);
    }).onError((error, stackTrace) async {
      dismissDialog();
      Get.snackbar(
        'Error creating account',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    await app.delete();
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
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

  Future<void> changePassword(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPasswordController.text);
    showLoading();
    await user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPasswordController.text).then((_) {
        dismissDialog();
        _changePasswordSuccess();
        Get.back();
        Get.snackbar('Password Changed Successfully',
            'You may now use your new password.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor);
      });
    }).catchError((err) {
      dismissDialog();
      Get.snackbar('Password Change Failed',
          'Your current password you have entered is not correct',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    });
  }

  Future<void> _createPatientUser(String _userID, BuildContext context) async {
    await firestore.collection('users').doc(_userID).set(<String, dynamic>{
      'userType': 'patient',
    });
    await firestore.collection('patients').doc(_userID).set(<String, dynamic>{
      'userID': _userID,
      'email': emailController.text.trim(),
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'profileImage': '',
      'validID': '',
      'validSelfie': '',
    }).then((value) async {
      await addPatientStatus(_userID);
      await addIncomingCallStatus(_userID);
      dismissDialog();
      signInWithEmailAndPassword(context);
    });
  }

  Future<void> addPatientStatus(String userID) async {
    await firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .set({
      'hasActiveQueueCons': false,
      'hasActiveQueueMA': false,
      'pStatus': false,
      'categoryID': '',
      'pendingVerification': false,
      'deviceToken': '',
      'notifBadge': 0,
      'queueCons': '',
      'queueMA': '',
    });
  }

  Future<void> addIncomingCallStatus(String userID) async {
    await firestore
        .collection('patients')
        .doc(userID)
        .collection('incomingCall')
        .doc('value')
        .set({
      'isCalling': false,
      'didReject': false,
      'patientJoined': false,
      'otherJoined': false,
      'channelId': '',
      'callerName': '',
      'from': ''
    });
  }

  //check user type of logged in user and navigate
  Future<void> getUserRole() async {
    await firestore.collection('users').doc(firebaseUser.value!.uid).get().then(
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
    if (userRole == 'patient') {
      await clearDeviceToken();
    }
    try {
      userSignedOut = true;
      await auth.signOut();
      log.i('signOut | User signs out successfully');
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers | User Input on authentication is cleared');
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    confirmPassController.clear();
  }

  Future<void> _changePasswordSuccess() async {
    log.i('_clearControllers | Change Password Success');
    currentPasswordController.clear();
    newPasswordController.clear();
    isObscureCurrentPW!.value = true;
    isObscureNewPW!.value = true;
  }

  Future<void> checkUserPlatform() async {
    log.i('checkUserPlatform | is user logged on web: $kIsWeb');
    if (userSignedOut == false) {
      switch (userRole) {
        case 'pswd-p':
        case 'pswd-h':
          await _initializePSWDModel();

          await checkAppRestriction(userRole);

          //await signOut();
          // showSimpleErrorDialog(
          //   errorDescription:
          //       'Your account has been disabled. Please contact this email address davnor.medicare@gmail.com',
          // );

          break;
        case 'admin':
          await _initializeAdminModel();
          await checkAppRestriction(userRole);
          break;
        case 'doctor':
          await _initializeDoctorModel();

          if (kIsWeb) {
            await Future.delayed(const Duration(seconds: 3),
                () => Get.offAllNamed(Routes.DOC_WEB_HOME));
          } else {
            await Future.delayed(const Duration(seconds: 3),
                () => Get.offAll(() => DoctorHomeScreen()));
          }

          break;
        case 'patient':
          await resetCallStatus(auth.currentUser!.uid);
          await _initializePatientModel();
          if (kIsWeb) {
            await Future.delayed(const Duration(seconds: 3),
                () => Get.offAllNamed(Routes.PATIENT_WEB_HOME));
          } else {
            await Future.delayed(const Duration(seconds: 3),
                () => Get.offAll(() => PatientHomeScreen()));
          }
          break;
        default:
          dismissDialog();
          showSimpleErrorDialog(
              errorDescription:
                  'Sorry, we could not fetch your data.\nPlease contact davnor.medicare@gmail.com');
      }
    }
  }

  //Restrict admin and pswd from logging in mobile app
  Future<void> checkAppRestriction(String? userRole) async {
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          await Future.delayed(const Duration(seconds: 3),
              () => Get.offAllNamed(Routes.PSWD_PERSONNEL_HOME));
          break;
        case 'pswd-h':
          await Future.delayed(const Duration(seconds: 3),
              () => Get.offAllNamed(Routes.PSWD_HEAD_HOME));
          break;
        case 'admin':
          await Future.delayed(const Duration(seconds: 3),
              () => Get.offAllNamed(Routes.ADMIN_HOME));
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
    await Future.delayed(const Duration(seconds: 3), () => route);
  }

  //initializedBaseOnUserRoles
  Future<void> _initializePatientModel() async {
    patientModel.value = await firestore
        .collection('patients')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
    log.i('_initializePatientModel | Initializing ${patientModel.value}');
    doneInitData.value = true;
  }

  Future<void> clearDeviceToken() async {
    await firestore
        .collection('patients')
        .doc(firebaseUser.value!.uid)
        .collection('status')
        .doc('value')
        .update({'deviceToken': ''});
  }

  Future<void> _initializeDoctorModel() async {
    doctorModel.value = await firestore
        .collection('doctors')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => DoctorModel.fromJson(doc.data()!));
    log.i('_initializePatientModel | Initializing ${doctorModel.value}');
    doneInitData.value = true;
  }

  Future<void> _initializePSWDModel() async {
    pswdModel.value = await firestore
        .collection('pswd_personnel')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => PswdModel.fromJson(doc.data()!));
    log.i('_initializePatientModel | Initializing ${pswdModel.value}');
    doneInitData.value = true;
  }

  Future<void> _initializeAdminModel() async {
    adminModel.value = await firestore
        .collection('admins')
        .doc(firebaseUser.value!.uid)
        .get()
        .then((doc) => AdminModel.fromJson(doc.data()!));
    log.i('_initializePatientModel | Initializing ${adminModel.value}');
    doneInitData.value = true;
  }

  void togglePasswordVisibility() {
    appController.toggleTextVisibility(isObscureText!);
  }

  void togglePasswordCVisibility() {
    appController.toggleTextVisibility(isObscureText2!);
  }

  void toggleCurrentPasswordVisibility() {
    appController.toggleTextVisibility(isObscureCurrentPW!);
  }

  void toggleNewPasswordVisibility() {
    appController.toggleTextVisibility(isObscureNewPW!);
  }

  void launchDoctorApplicationForm() {
    _urlLauncherService.launchURL(formUrl);
  }

  void launchDoctorApplicationEmail() {
    _urlLauncherService.launchURL(emailScheme);
  }

  Future<void> resetCallStatus(String uid) async {
    await firestore
        .collection('patients')
        .doc(uid)
        .collection('incomingCall')
        .doc('value')
        .update({
      'patientJoined': false,
      'isCalling': false,
      'didReject': false,
      'otherJoined': false,
      'channelId': '',
      'from': '',
      'callerName': ''
    });
  }
}
