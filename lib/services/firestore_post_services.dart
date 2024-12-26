import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Post_model.dart';

class FirestorePostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost(PostModel post) async {
    try {
      await _db.collection('Posts').add(post.toFirestore());
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Stream<List<PostModel>> getPosts() {
    return _db
        .collection('Posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return PostModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

}
