import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class GeneralMARequestModel {
  GeneralMARequestModel(
      {required this.maID,
      required this.requesterID,
      required this.fullName,
      required this.age,
      required this.address,
      required this.gender,
      required this.type,
      required this.prescriptions,
      required this.validID,
      this.receiverID,
      this.isAccepted = false,
      this.isTransferred = false,
      this.receivedBy = '',
      this.isApproved = false,
      this.isMedReady = false,
      this.medWorth = '',
      this.pharmacy = '',
      required this.dateRqstd,
      this.dateClaimed});

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
  String? receiverID;
  bool? isAccepted;
  bool? isTransferred;
  String? receivedBy;
  bool? isApproved;
  bool? isMedReady;
  String? medWorth;
  String? pharmacy;
  Timestamp? dateClaimed;
  Rxn<PatientModel> requester = Rxn<PatientModel>(); //data of the requester
}
