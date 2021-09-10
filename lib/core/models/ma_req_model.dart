import 'package:cloud_firestore/cloud_firestore.dart';

//NOT SURE ABOUT THIS LOL

class MedicalAssistanceModel {
  MedicalAssistanceModel({
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

  factory MedicalAssistanceModel.fromJson(Map<String, dynamic> json) =>
      MedicalAssistanceModel(
        requesterID: json['requesterID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        address: json['address'] as String,
        gender: json['gender'] as String,
        type: json['type'] as String,
        prescriptions: json['prescriptions'] as String,
        validID: json['validID'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
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
