import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({
    required this.photo,
    required this.from,
    required this.action,
    required this.subject,
    required this.message,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        photo: json['photo'] as String,
        from: json['from'] as String,
        action: json['action'] as String,
        subject: json['subject'] as String,
        message: json['message'] as String,
        createdAt: json['createdAt'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'from': from,
        'action': action,
        'subject': subject,
        'message': message,
        'createdAt': createdAt,
      };

  final String? photo;
  final String? from;
  final String? action;
  final String? subject;
  final String? message;
  final Timestamp? createdAt;
}
