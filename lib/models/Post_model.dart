class Post {
  final String userId;
  final String id;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt
    };
  }

   static Post fromMap(String id, Map<String, dynamic> map) {
    return Post(
      id: id,
      userId: map['userId'],
      content: map['content'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}
