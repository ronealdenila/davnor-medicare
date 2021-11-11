// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class MARequestModel {
  MARequestModel({
    required this.maID,
    required this.requesterID,
    required this.fullName,
    required this.age,
    required this.address,
    required this.gender,
    required this.type,
    required this.prescriptions,
    required this.validID,
    required this.date_rqstd,
  });

  factory MARequestModel.fromJson(Map<String, dynamic> json) => MARequestModel(
        maID: json['maID'] as String,
        requesterID: json['requesterID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        type: json['type'] as String,
        prescriptions: json['prescriptions'] as String,
        validID: json['validID'] as String,
        date_rqstd: json['date_rqstd'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'maID': maID,
        'patientId': requesterID,
        'fullName': fullName,
        'age': age,
        'address': address,
        'gender': gender,
        'type': type,
        'prescriptions': prescriptions,
        'validID': validID,
        'date_rqstd': date_rqstd,
      };

  String? maID;
  String? requesterID;
  String? fullName;
  String? age;
  String? address;
  String? gender;
  String? type;
  String? prescriptions;
  String? validID;
  Timestamp? date_rqstd;
  Rxn<PatientModel> requester = Rxn<PatientModel>(); //data of the requester
}

class OnProgressMAModel {
  OnProgressMAModel({
    this.maID,
    this.requesterID,
    this.fullName,
    this.age,
    this.address,
    this.gender,
    this.type,
    this.prescriptions,
    this.dateRqstd,
    this.validID,
    this.isTransferred = false,
    this.receivedBy = '',
    this.isApproved = false,
    this.isMedReady = false,
    this.medWorth = '',
    this.pharmacy = '',
  });

  factory OnProgressMAModel.fromJson(Map<String, dynamic> json) =>
      OnProgressMAModel(
        maID: json['maID'] as String,
        requesterID: json['requesterID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        type: json['type'] as String,
        prescriptions: json['prescriptions'] as String,
        validID: json['validID'] as String,
        isTransferred: json['isTransferred'] as bool,
        receivedBy: json['receivedBy'] as String,
        isApproved: json['isApproved'] as bool,
        isMedReady: json['isMedReady'] as bool,
        medWorth: json['medWorth'] as String,
        pharmacy: json['pharmacy'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'maID': maID,
        'requesterID': requesterID,
        'fullName': fullName,
        'age': age,
        'address': address,
        'gender': gender,
        'type': type,
        'prescriptions': prescriptions,
        'validID': validID,
        'dateRqstd': dateRqstd,
        'isTransferred': isTransferred,
        'receivedBy': receivedBy,
        'isApproved': isApproved,
        'isMedReady': isMedReady,
        'medWorth': medWorth,
        'pharmacy': pharmacy,
      };

  String? maID;
  String? requesterID;
  String? fullName;
  String? age;
  String? address;
  String? gender;
  String? type;
  String? prescriptions;
  String? validID;
  bool? isTransferred;
  String? receivedBy;
  bool? isApproved;
  bool? isMedReady;
  String? medWorth;
  String? pharmacy;
  Timestamp? dateRqstd;
  Rxn<PatientModel> requester = Rxn<PatientModel>(); //data of the requester
}

class MAHistoryModel {
  MAHistoryModel(
      {this.maID,
      this.requesterID,
      this.fullName,
      this.age,
      this.address,
      this.gender,
      this.type,
      this.prescriptions,
      this.validID,
      this.dateRqstd,
      this.receivedBy,
      this.medWorth,
      this.pharmacy,
      this.dateClaimed});

  factory MAHistoryModel.fromJson(Map<String, dynamic> json) => MAHistoryModel(
        maID: json['maID'] as String,
        requesterID: json['requesterID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        type: json['type'] as String,
        prescriptions: json['prescriptions'] as String,
        validID: json['validID'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
        receivedBy: json['receivedBy'] as String,
        medWorth: json['medWorth'] as String,
        pharmacy: json['pharmacy'] as String,
        dateClaimed: json['dateClaimed'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'maID': maID,
        'patientId': requesterID,
        'fullName': fullName,
        'age': age,
        'address': address,
        'gender': gender,
        'type': type,
        'prescriptions': prescriptions,
        'validID': validID,
        'dateRqstd': dateRqstd,
        'receivedBy': receivedBy,
        'medWorth': medWorth,
        'pharmacy': pharmacy,
        'dateClaimed': dateClaimed,
      };

  String? maID;
  String? requesterID;
  String? fullName;
  String? age;
  String? address;
  String? gender;
  String? type;
  String? prescriptions;
  String? validID;
  Timestamp? dateRqstd;
  String? receivedBy;
  String? medWorth;
  String? pharmacy;
  Timestamp? dateClaimed;
  Rxn<PatientModel> patient = Rxn<PatientModel>(); //data of the requester
}
