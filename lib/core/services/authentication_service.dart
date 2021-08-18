import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';

import 'package:davnor_medicare/constants/route_paths.dart' as routes;

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userRole;
  final NavigationService _navigationService = locator<NavigationService>();

  Future loginWithEmail({
    required String? email,
    required String? password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      await getUserRole();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  getUserRole() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance //get user roles
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userRole = documentSnapshot["usertype"];
        }
      });
      await checkUserPlatform();
    }
  }

  checkUserPlatform() async {
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          _navigationService.navigateTo(routes.PSWDPersonnelHomeRoute);
          break;
        case 'pswd-h':
          _navigationService.navigateTo(routes.PSWDHeadHomeRoute);
          break;
        case 'admin':
          _navigationService.navigateTo(routes.AdminHomeRoute);
          break;
        case 'doctor':
          _navigationService.navigateTo(routes.DoctorHomeRoute);
          break;
        case 'patient':
          _navigationService.navigateTo(routes.PatientHomeRoute);
          break;
        default:
          print('Error Occured'); //TODO: Error Dialog
      }
    } else {
      //Mobile Platform
      if (userRole == 'pswd-p' || userRole == 'pswd-h' || userRole == 'admin') {
        print('Please log in on Web Application'); //TODO: Error Dialog
      } else {
        switch (userRole) {
          case 'doctor':
            _navigationService.navigateTo(routes.DoctorHomeRoute);
            break;
          case 'patient':
            // Since mag navigate man ta dria na method (out of context). akong
            // gisolution is mag navigate ta without context. (R)
            // reference:
            // https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
            _navigationService.navigateTo(routes.PatientHomeRoute);
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog
        }
      }
    }
  }
}
