import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    if (password != confirmPassword) {
      throw 'Passwords do not match';
    }

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).set({
        'name': name,
        'email': email,
        'profile': null,
        'created_at': FieldValue.serverTimestamp(),
      });
    }
    return user;
  }

  Future<User?> loginWithEmailName(String identifier, String password) async {
    String? email;
    if (identifier.contains('@')) {
      email = identifier;
    } else {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Users')
          .where('name', isEqualTo: identifier)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw 'No user found with the provided name';
      }
      email = querySnapshot.docs.first['email'];
    }

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email!,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null && !user.emailVerified) {
      await sendEmailVerification();
      await _auth.signOut();
      throw 'Please verify your email before logging in.';
    }

    return user;
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user == null) throw 'No user is logged in.';
    if (user.emailVerified) throw 'Your email is already verified.';

    await user.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
