//User Model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PatientModel {
  PatientModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.pStatus,
    required this.validId,
    required this.validSelfie,
    required this.hasActiveQueue,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImage: json['profileImage'] as String,
        pStatus: json['pStatus'] as bool,
        validId: json['validID'] as String,
        validSelfie: json['validSelfie'] as String,
        hasActiveQueue: json['hasActiveQueue'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'profileImage': profileImage,
        'pStatus': pStatus,
        'validID': validId,
        'validSelfie': validSelfie,
        'hasActiveQueue': hasActiveQueue,
      };

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final bool? pStatus;
  final String? validId;
  final String? validSelfie;
  final bool? hasActiveQueue;
}

class DoctorModel {
  DoctorModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.department,
    required this.clinicHours,
    required this.profileImage,
    required this.numToAccomodate,
    required this.dStatus,
    required this.hasOngoingCons,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        title: json['title'] as String,
        department: json['department'] as String,
        clinicHours: json['clinicHours'] as String,
        profileImage: json['profileImage'] as String,
        numToAccomodate: json['numToAccomodate'] as int,
        dStatus: json['dStatus'] as bool,
        hasOngoingCons: json['hasOngoingCons'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'title': title,
        'department': department,
        'clinicHours': clinicHours,
        'profileImage': profileImage,
        'numToAccomodate': numToAccomodate,
        'dStatus': dStatus,
        'hasOngoingCons': hasOngoingCons,
      };
  String? email;
  String? firstName;
  String? lastName;
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
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImage: json['profileImage'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'profileImage': profileImage,
      };
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage; //data that will change
}

class PswdModel {
  PswdModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.profileImage,
  });

  factory PswdModel.fromJson(Map<String, dynamic> json) => PswdModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        position: json['position'] as String,
        profileImage: json['profileImage'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'position': position,
        'profileImage': profileImage,
      };

  String? email;
  String? firstName;
  String? lastName;
  String? position;
  String? profileImage; //data that will change
}
