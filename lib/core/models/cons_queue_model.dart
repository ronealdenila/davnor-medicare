import 'package:cloud_firestore/cloud_firestore.dart';

class ConsQueueModel {
  ConsQueueModel({
    this.categoryID,
    this.consID,
    this.requesterID,
    this.queueNum,
    this.dateCreated,
  });

  factory ConsQueueModel.fromJson(Map<String, dynamic> json) => ConsQueueModel(
        categoryID: json['categoryID'] as String,
        requesterID: json['requesterID'] as String,
        consID: json['consID'] as String,
        queueNum: json['queueNum'] as String,
        dateCreated: json['dateCreated'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'categoryID': categoryID,
        'requesterID': requesterID,
        'consID': consID,
        'queueNum': queueNum,
        'dateCreated': dateCreated,
      };

  String? categoryID;
  String? requesterID;
  String? consID;
  String? queueNum;
  Timestamp? dateCreated;
}
