import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class GeneralMARequestModel {
  GeneralMARequestModel(
      {required this.requesterID,
      required this.fullName,
      required this.age,
      required this.address,
      required this.gender,
      required this.type,
      required this.prescriptions,
      required this.validID,
      this.isTransferred = false,
      this.receivedBy = '',
      this.isApproved = false,
      this.isMedReady = false,
      this.medWorth = '',
      this.pharmacy = '',
      required this.dateRqstd,
      this.dateClaimed});

  String? requesterID;
  String? fullName;
  String? age;
  String? address;
  String? gender;
  String? type;
  String? prescriptions;
  String? validID;
  Timestamp? dateRqstd;
  bool? isTransferred;
  String? receivedBy;
  bool? isApproved;
  bool? isMedReady;
  String? medWorth;
  String? pharmacy;
  Timestamp? dateClaimed;
  Rxn<PatientModel> requester = Rxn<PatientModel>(); //data of the requester
}


  //NOT NEEDED
  // factory GeneralMARequestModel.fromJson(Map<String, dynamic> json) =>
  //     GeneralMARequestModel(
  //       requesterID: json['requesterID'] as String,
  //       fullName: json['fullName'] as String,
  //       age: json['age'] as String,
  //       address: json['address'] as String,
  //       gender: json['gender'] as String,
  //       type: json['type'] as String,
  //       prescriptions: json['prescriptions'] as String,
  //       validID: json['validID'] as String,
  //       dateRqstd: json['dateRqstd'] as Timestamp,
  //       isTransferred: json['isTransferred'] as bool,
  //       receivedBy: json['receivedBy'] as String,
  //       isApproved: json['isApproved'] as bool,
  //       isMedReady: json['isMedReady'] as bool,
  //       medWorth: json['medWorth'] as String,
  //       pharmacy: json['pharmacy'] as String,
  //       dateClaimed: json['dateClaimed'] as Timestamp,
  //     );

  // Map<String, dynamic> toJson() => {
  //       'patientId': requesterID,
  //       'fullName': fullName,
  //       'age': age,
  //       'address': address,
  //       'gender': gender,
  //       'type': type,
  //       'prescriptions': prescriptions,
  //       'validID': validID,
  //       'dateRqstd': dateRqstd,
  //       'isTransferred': isTransferred,
  //       'receivedBy': receivedBy,
  //       'isApproved': isApproved,
  //       'isMedReady': isMedReady,
  //       'medWorth': medWorth,
  //       'pharmacy': pharmacy,
  //       'dateClaimed': dateClaimed,
  //     };
