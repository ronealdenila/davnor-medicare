import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class MARequestModel {
  MARequestModel({
    this.requesterID,
    this.fullName,
    this.age,
    this.address,
    this.gender,
    this.type,
    this.prescriptions,
    this.validID,
    this.dateRqstd,
    this.isTurn,
  });

  factory MARequestModel.fromJson(Map<String, dynamic> json) => MARequestModel(
        requesterID: json['requesterID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        type: json['type'] as String,
        prescriptions: json['prescriptions'] as String,
        validID: json['validID'] as String,
        dateRqstd: json['date_rqstd'] as Timestamp,
        isTurn: json['isTurn'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'patientId': requesterID,
        'fullName': fullName,
        'age': age,
        'address': address,
        'gender': gender,
        'type': type,
        'prescriptions': prescriptions,
        'validID': validID,
        'dateRqstd': dateRqstd,
        'isTurn': isTurn,
      };

  String? requesterID;
  String? fullName;
  String? age;
  String? address;
  String? gender;
  String? type;
  String? prescriptions;
  String? validID;
  Timestamp? dateRqstd;
  bool? isTurn;
}

class MAHistoryModel {
  MAHistoryModel(
      {this.requesterID,
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
