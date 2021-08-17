import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userRole;

  Future loginWithEmail({
    required String? email,
    required String? password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
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
            print('Logged in as patient'); //TODO: Navigate to patient screen
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog
        }
      }
    }
  }
}
