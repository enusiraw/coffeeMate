class CommentModel {
  final String userId;
  final String comment;
  final DateTime commented_time;

  CommentModel({
    required this.userId,
    required this.comment,
    required this.commented_time,
  });

  factory CommentModel.fromFirestore(Map<String, dynamic> doc) {
    return CommentModel(
        userId: doc["userId"],
        comment: doc["comment"],
        commented_time: doc["time"]);
  }
}
