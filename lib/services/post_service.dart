import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class PostService {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> pickMedia({required bool fromCamera}) async {
    List<XFile> selectedFiles = [];

    if (fromCamera) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedFiles.add(pickedFile);
      }
    } else {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        selectedFiles.addAll(pickedFiles);
      }
    }

    return selectedFiles;
  }

  // Upload images/videos to Firebase Storage and return their URLs
  Future<List<String>> uploadMedia(List<XFile> files) async {
    List<String> mediaUrls = [];
    for (var file in files) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('Posts').child(fileName);
      UploadTask uploadTask = ref.putFile(File(file.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      mediaUrls.add(downloadUrl);
    }
    return mediaUrls;
  }

  // Create a new post in Firestore
  Future<void> createPost({
    required String userId,
    required String description,
    required String location,
    required List<String> mediaUrls,
  }) async {
    try {
      String postId = FirebaseFirestore.instance.collection('Posts').doc().id;

      // Create a post in the 'posts' collection
      await FirebaseFirestore.instance.collection('Posts').doc(postId).set({
        'userId': userId,
        'description': description,
       'location': location,
        'mediaUrls': mediaUrls,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Create a post in the 'user_posts' subcollection of the user's document
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('created_posts')
          .doc(postId)
          .set({
        'description': description,
        //'location': location,
        'mediaUrls': mediaUrls,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error creating post: $e');
      throw Exception('Failed to create post');
    }
  }
}
