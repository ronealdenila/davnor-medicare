import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:get/get.dart';

class ConsultationModel {
  ConsultationModel({
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
        'patientId': patientId,
        'fullName': fullName,
        'age': age,
        'category': category,
        'dateRqstd': dateRqstd,
        'description': description,
        'isFollowUp': isFollowUp,
        'imgs': imgs,
      };

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
