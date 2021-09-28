import 'package:cloud_firestore/cloud_firestore.dart';

//NOT SURE ABOUT THIS LOL

//Ako lang gibutangan og required para pagtawag sa model i set na niya daan ang
//constructor (R)
class MedicalAssistanceModel {
  MedicalAssistanceModel({
    required this.requesterID,
    required this.fullName,
    required this.age,
    required this.address,
    required this.gender,
    required this.type,
    required this.prescriptions,
    required this.validID,
    required this.dateRqstd,
    required this.isTurn,
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
