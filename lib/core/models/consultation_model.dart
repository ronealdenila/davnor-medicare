import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class ConsultationModel {
  ConsultationModel({
    this.consID,
    this.patientId,
    this.fullName,
    this.age,
    this.category,
    this.dateRqstd,
    this.description,
    this.isFollowUp,
    this.imgs,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        consID: json['consID'] as String,
        patientId: json['patientId'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        category: json['category'] as String,
        dateRqstd: json['dateRqstd'] as String,
        description: json['description'] as String,
        isFollowUp: json['isFollowUp'] as bool,
        imgs: json['imgs'] as String,
      );

  Map<String, dynamic> toJson() => {
        'consID': consID,
        'patientId': patientId,
        'fullName': fullName,
        'age': age,
        'category': category,
        'dateRqstd': dateRqstd,
        'description': description,
        'isFollowUp': isFollowUp,
        'imgs': imgs,
      };
  String? consID;
  String? patientId;
  String? fullName;
  String? age;
  String? category;
  String? dateRqstd;
  String? description;
  bool? isFollowUp;
  String? imgs;
  Rxn<PatientModel> data = Rxn<PatientModel>();
}

class ConsultationHistoryModel {
  ConsultationHistoryModel({
    this.consID,
    this.patientId,
    this.docID,
    this.fullName,
    this.age,
    this.dateRqstd,
    this.dateConsStart,
    this.dateConsEnd,
  });

  factory ConsultationHistoryModel.fromJson(Map<String, dynamic> json) =>
      ConsultationHistoryModel(
        consID: json['consID'] as String,
        patientId: json['patientId'] as String,
        docID: json['docID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
        dateConsStart: json['dateConsStart'] as Timestamp,
        dateConsEnd: json['dateConsEnd'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'consID': consID,
        'patientId': patientId,
        'docID': docID,
        'fullName': fullName,
        'age': age,
        'dateRqstd': dateRqstd,
        'dateConsStart': dateConsStart,
        'dateConsEnd': dateConsEnd,
      };

  String? consID;
  String? patientId;
  String? docID;
  String? fullName;
  String? age;
  Timestamp? dateRqstd;
  Timestamp? dateConsStart;
  Timestamp? dateConsEnd;
  Rxn<PatientModel> patient = Rxn<PatientModel>(); //data of the requester
  Rxn<DoctorModel> doc = Rxn<DoctorModel>(); //data of the doctor
}

class LiveConsultationModel {
  LiveConsultationModel({
    this.consID,
    this.patientID,
    this.docID,
    this.fullName,
    this.age,
    this.dateRqstd,
    this.dateConsStart,
  });

  factory LiveConsultationModel.fromJson(Map<String, dynamic> json) =>
      LiveConsultationModel(
        consID: json['consID'] as String,
        patientID: json['patientID'] as String,
        docID: json['docID'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        dateRqstd: json['dateRqstd'] as Timestamp,
        dateConsStart: json['dateConsStart'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'consID': consID,
        'patientID': patientID,
        'docID': docID,
        'fullName': fullName,
        'age': age,
        'dateRqstd': dateRqstd,
        'dateConsStart': dateConsStart,
      };

  String? consID;
  String? patientID;
  String? docID;
  String? fullName;
  String? age;
  Timestamp? dateRqstd;
  Timestamp? dateConsStart;
  Rxn<PatientModel> patient = Rxn<PatientModel>(); //data of the requester
  Rxn<DoctorModel> doc = Rxn<DoctorModel>(); //data of the doctor
}
