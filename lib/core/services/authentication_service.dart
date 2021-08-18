import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_data.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userRole;
  UserData? initializeUser;

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
      await checkUserPlatform(currentUser);
    }
  }

  checkUserPlatform(var currentUser) async {
    if (kIsWeb) {
      switch (userRole) {
        case 'pswd-p':
          initializePSWDPData(currentUser);
          print('Logged in as PSWD Personnel'); //TODO: Navigate pswd personnel
          break;
        case 'pswd-h':
          initializePSWDPData(currentUser);
          print('Logged in as PSWD Head'); //TODO: Navigate to pswd head screen
          break;
        case 'admin':
          initializeAdminData(currentUser);
          print('Logged in as Admin'); //TODO: Navigate to admin screen
          break;
        case 'doctor':
          initializeDoctorData(currentUser);
          print('Logged in as doctor'); //TODO: Navigate to doctor screen
          break;
        case 'patient':
          initializePatientData(currentUser);
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
            initializeDoctorData(currentUser);
            print('Logged in as doctor'); //TODO: Navigate to doctor screen
            break;
          case 'patient':
            initializePatientData(currentUser);
            print('Logged in as patient');
            // Since mag navigate man ta dria na method (out of context). akong
            // gisolution is mag navigate ta without context. (R)
            // reference:
            // https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
            //_navigationService.navigateTo(routes.PatientHomeRoute);
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog
        }
      }
    }
    print(initializeUser.toString());
  }

  initializePatientData(var currentUser) async {
    await FirebaseFirestore.instance //get user roles
        .collection('patient')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        initializeUser = UserData.forPatient(
            userID: currentUser.uid,
            firstName: documentSnapshot["firstName"],
            lastName: documentSnapshot["lastName"],
            email: documentSnapshot["email"],
            profileImage: documentSnapshot["profileImage"],
            pStatus: documentSnapshot["pStatus"],
            validID: documentSnapshot["validID"],
            validSelfie: documentSnapshot["validSelfie"],
            hasActiveQueue: documentSnapshot["hasActiveQueue"]);
      }
    });
    //print(initializeUser.userID);
  }

  initializeDoctorData(var currentUser) async {
    await FirebaseFirestore.instance //get user roles
        .collection('doctor')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        initializeUser = UserData.forDoctor(
            userID: currentUser.uid,
            firstName: documentSnapshot["firstName"],
            lastName: documentSnapshot["lastName"],
            email: documentSnapshot["email"],
            profileImage: documentSnapshot["profileImage"],
            dStatus: documentSnapshot["dStatus"],
            title: documentSnapshot["title"],
            department: documentSnapshot["department"],
            clinicHours: documentSnapshot["clinicHours"],
            numToAccomodate: documentSnapshot["numToAccomodate"],
            hasOngoingCons: documentSnapshot["hasOngoingCons"]);
      }
    });
  }

  initializePSWDPData(var currentUser) async {
    await FirebaseFirestore.instance //get user roles
        .collection('pswd_personnel')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        initializeUser = UserData.forPSWD(
            userID: currentUser.uid,
            firstName: documentSnapshot["firstName"],
            lastName: documentSnapshot["lastName"],
            email: documentSnapshot["email"],
            profileImage: documentSnapshot["profileImage"],
            position: documentSnapshot["position"]);
      }
    });
  }

  initializeAdminData(var currentUser) async {
    await FirebaseFirestore.instance //get user roles
        .collection('admin')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        initializeUser = UserData.forAdmin(
            userID: currentUser.uid,
            firstName: documentSnapshot["firstName"],
            lastName: documentSnapshot["lastName"],
            email: documentSnapshot["email"],
            profileImage: documentSnapshot["profileImage"]);
      }
    });
  }
}
