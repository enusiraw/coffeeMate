// ignore_for_file: non_constant_identifier_names

class PostModel {
  final String userId;
  final String title;
  final String body;
  final DateTime posted_time;
  final int like_count;
  final int comment_count;

  PostModel(
      {required this.userId,
      required this.body,
      required this.like_count,
      required this.posted_time,
      required this.title,
      required this.comment_count});

  factory PostModel.fromFirestore(Map<String, dynamic> doc, String id) {
    return PostModel(
        userId: doc["userId"],
        body: doc["body"],
        like_count: doc["like_count"] ?? 0,
        posted_time: doc["posted_time"],
        title: doc["title"],
        comment_count: doc["comment_count"] ?? 0);
  }
}
