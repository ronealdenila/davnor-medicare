import 'package:cloud_firestore/cloud_firestore.dart';

class PrescriptionModel {
  PrescriptionModel({
    this.patientId,
    this.fullName,
    this.age,
    this.category,
    this.dateRqstd,
    this.description,
    this.isFollowUp,
    this.imgs,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
        patientId: json['patient_id'] as String,
        fullName: json['fullName'] as String,
        age: json['age'] as String,
        category: json['category'] as String,
        dateRqstd: json['date_rqstd'] as Timestamp,
        description: json['description'] as String,
        isFollowUp: json['isFollowUp'] as bool,
        imgs: json['imgs'] as String,
      );

  Map<String, dynamic> toJson() => {
        'patient_id': patientId,
        'fullName': fullName,
        'age': age,
        'category': category,
        'date_rqstd': dateRqstd,
        'description': description,
        'isFollowUp': isFollowUp,
        'imgs': imgs,
      };

  String? patientId;
  String? fullName;
  String? age;
  String? category;
  Timestamp? dateRqstd;
  String? description;
  bool? isFollowUp;
  String? imgs;
}
