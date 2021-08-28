import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  ArticleModel({
    required this.title,
    required this.content,
    required this.photoURL,
    required this.source,
    // required this.date,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'] as String,
        content: json['content'] as String,
        photoURL: json['photoURL'] as String,
        source: json['source'] as String,
        // date: json['date'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'photoURL': photoURL,
        'source': source,
        // 'date': date,
      };

  final String? title;
  final String? content;
  final String? photoURL;
  final String? source;
  // final Timestamp? date;
}
