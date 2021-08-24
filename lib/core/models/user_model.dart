//User Model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// if dili magbutang og required mag fetch sa firestore kahit null ang value
class PatientModel {
  PatientModel({
    this.email,
    this.firstName,
    this.lastName,
    this.userType,
    this.profileImage,
    this.pStatus,
    this.validID,
    this.validSelfie,
    this.hasActiveQueue,
  });

  PatientModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    userType = (snapshot.data() as dynamic)['userType'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
    validID = (snapshot.data() as dynamic)['validID'] as String;
    validSelfie = (snapshot.data() as dynamic)['validSelfie'] as String;
    pStatus = (snapshot.data() as dynamic)['pStatus'] as bool;
    hasActiveQueue = (snapshot.data() as dynamic)['hasActiveQueue'] as bool;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? userType;
  String? profileImage;
  String? validID;
  String? validSelfie;
  bool? pStatus;
  bool? hasActiveQueue;
}

class DoctorModel {
  DoctorModel({
    this.email,
    this.firstName,
    this.lastName,
    this.userType,
    this.title,
    this.department,
    this.clinicHours,
    this.profileImage,
    this.numToAccomodate,
    this.dStatus,
    this.hasOngoingCons,
  });

  DoctorModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    userType = (snapshot.data() as dynamic)['userType'] as String;
    title = (snapshot.data() as dynamic)['title'] as String;
    department = (snapshot.data() as dynamic)['department'] as String;
    clinicHours = (snapshot.data() as dynamic)['clinicHours'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
    numToAccomodate = (snapshot.data() as dynamic)['numToAccomodate'] as int;
    dStatus = (snapshot.data() as dynamic)['dStatus'] as bool;
    hasOngoingCons = (snapshot.data() as dynamic)['hasOngoingCons'] as bool;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? userType;
  String? title;
  String? department;
  String? clinicHours;
  String? profileImage;
  int? numToAccomodate;
  bool? dStatus;
  bool? hasOngoingCons;
}

class AdminModel {
  AdminModel({
    this.email,
    this.firstName,
    this.lastName,
    this.userType,
    this.profileImage,
  });

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    userType = (snapshot.data() as dynamic)['userType'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? userType;
  String? profileImage;
}

class PswdModel {
  PswdModel({
    this.email,
    this.firstName,
    this.lastName,
    this.userType,
    this.position,
    this.profileImage,
  });

  PswdModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    userType = (snapshot.data() as dynamic)['userType'] as String;
    position = (snapshot.data() as dynamic)['position'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? userType;
  String? position;
  String? profileImage;
}
