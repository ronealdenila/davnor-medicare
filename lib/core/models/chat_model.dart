import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  ChatModel({
    this.senderID,
    this.message,
    this.dateCreated,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        senderID: json['senderID'] as String,
        message: json['message'] as String,
        dateCreated: json['dateCreated'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'senderID': senderID,
        'message': message,
        'dateCreated': dateCreated,
      };

  String? senderID;
  String? message;
  Timestamp? dateCreated;
}
