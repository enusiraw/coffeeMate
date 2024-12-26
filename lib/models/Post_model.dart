// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userId;
  final String text;
  final DateTime posted_time;
  final int likes;
  final int comments;

  PostModel({
    required this.userId,
    required this.text,
    required this.posted_time,
    required this.likes,
    required this.comments,
  });

  factory PostModel.fromFirestore(Map<String, dynamic> doc, String id) {
    return PostModel(
      userId: doc["userId"],
      text: doc["text"],
      posted_time: (doc["timestamp"] as Timestamp).toDate(),
      likes: doc["likes"] ?? 0,
      comments: doc["comments"] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "text": text,
      "timestamp": Timestamp.fromDate(posted_time),
      "likes": likes,
      "comments": comments,
    };
  }
}
