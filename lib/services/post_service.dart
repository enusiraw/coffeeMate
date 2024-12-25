import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Post_model.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addPost(String content, String? imageUrl) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw 'User is not logged in';
    }

    Post post = Post(
      id: _firestore.collection('posts').doc().id,
      userId: user.uid,
      content: content,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    try {
      await _firestore.collection('posts').doc(post.id).set(post.toMap());
    } catch (e) {
      throw 'Failed to add post: $e';
    }
  }

  Stream<List<Post>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => Post.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
