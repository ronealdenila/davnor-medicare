import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.message,
    required this.from,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'] as String,
        message: json['message'] as String,
        from: json['from'] as String,
        createdAt: json['createdAt'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'from': from,
        'createdAt': createdAt,
      };

  final String? title;
  final String? message;
  final String? from;
  final Timestamp? createdAt;
}
