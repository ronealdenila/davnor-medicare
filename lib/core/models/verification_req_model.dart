import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class VerificationReqModel {
  VerificationReqModel({
    this.patientID,
    this.validID,
    this.validSelfie,
    this.dateRqstd,
  });

  factory VerificationReqModel.fromJson(Map<String, dynamic> json) =>
      VerificationReqModel(
        patientID: json['patientID'] as String,
        validID: json['validID'] as String,
        validSelfie: json['validSelfie'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'patientID': patientID,
        'validID': validID,
        'validSelfie': validSelfie,
        'dateRqstd': dateRqstd,
      };

  String? patientID;
  String? validID;
  String? validSelfie;
  Timestamp? dateRqstd;
  Rxn<PatientModel> data = Rxn<PatientModel>();
}
