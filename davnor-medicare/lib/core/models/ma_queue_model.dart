import 'package:cloud_firestore/cloud_firestore.dart';

class MAQueueModel {
  MAQueueModel({
    this.maID,
    this.requesterID,
    this.queueNum,
    this.dateCreated,
  });

  factory MAQueueModel.fromJson(Map<String, dynamic> json) => MAQueueModel(
        maID: json['maID'] as String,
        requesterID: json['requesterID'] as String,
        queueNum: json['queueNum'] as String,
        dateCreated: json['dateCreated'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'maID': maID,
        'requesterID': requesterID,
        'queueNum': queueNum,
        'dateCreated': dateCreated,
      };

  String? maID;
  String? requesterID;
  String? queueNum;
  Timestamp? dateCreated;
}
