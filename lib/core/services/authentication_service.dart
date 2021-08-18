import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
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

  // dapat lahi unta ni siya nga service folder e.g. firestore_service
  getUserRole() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance //get user roles
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userRole = documentSnapshot["usertype"];
            print('User Type: ' + userRole!);
            print('First Name: ' + documentSnapshot["firstname"]);
            print('Last Name: ' + documentSnapshot["lastname"]);
          }
        },
      );
      await checkUserPlatform();
    }
  }

  checkUserPlatform() async {
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          print('Logged in as PSWD Personnel'); //TODO: Navigate pswd personnel

          break;
        case 'pswd-h':
          print('Logged in as PSWD Head'); //TODO: Navigate to pswd head screen
          break;
        case 'admin':
          print('Logged in as Admin'); //TODO: Navigate to admin screen
          break;
        case 'doctor':
          print('Logged in as doctor'); //TODO: Navigate to doctor screen
          break;
        case 'patient':
          print('Logged in as patient'); //TODO: Navigate to patient screen
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
            print('Logged in as doctor'); //TODO: Navigate to doctor screen
            break;
          case 'patient':
            print('Logged in as patient');
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
