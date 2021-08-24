//User Model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

//gamit kaayo si required / null safety kay para di nato mag appear ang null error
class PatientModel {
  PatientModel({
    required this.email,
    required this.firstname,
    required this.lastName,
    required this.profileImage,
    required this.pStatus,
    required this.validId,
    required this.validSelfie,
    required this.hasActiveQueue,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        email: json['email'] as String,
        firstname: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImage: json['profileImage'] as String,
        pStatus: json['pStatus'] as bool,
        validId: json['validID'] as String,
        validSelfie: json['validSelfie'] as String,
        hasActiveQueue: json['hasActiveQueue'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstname': firstname,
        'lastName': lastName,
        'profileImage': profileImage,
        'pStatus': pStatus,
        'validID': validId,
        'validSelfie': validSelfie,
        'hasActiveQueue': hasActiveQueue,
      };

  final String? email;
  final String? firstname;
  final String? lastName;
  final String? profileImage;
  final bool? pStatus;
  final String? validId;
  final String? validSelfie;
  final bool? hasActiveQueue;
}

class DoctorModel {
  DoctorModel({
    this.email,
    this.firstName,
    this.lastName,
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
  String? title;
  String? department;
  String? clinicHours;
  //data that will change --------
  String? profileImage;
  int? numToAccomodate;
  bool? dStatus;
  bool? hasOngoingCons;
  // -----------------------------
}

class AdminModel {
  AdminModel({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? profileImage; //data that will change
}

class PswdModel {
  PswdModel({
    this.email,
    this.firstName,
    this.lastName,
    this.position,
    this.profileImage,
  });

  PswdModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    position = (snapshot.data() as dynamic)['position'] as String;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  String? position;
  String? profileImage; //data that will change
}
