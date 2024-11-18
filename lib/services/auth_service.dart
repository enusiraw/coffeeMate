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

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

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
  } on FirebaseAuthException catch (e) {
    print('Sign Up error: $e');
    throw e.message ?? 'Unknown error occurred';
  }
}

 Future<User?> loginWithEmailName(
    String identifier, String password) async {
  try {
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
      await _auth.signOut();
      throw 'Please verify your email before logging in.';
    }

    return user;
  } on FirebaseAuthException catch (e) {
    print('Login error: $e');
    throw e.message ?? 'Unknown error occurred';
  } catch (e) {
    print('Error during login: $e');
    throw e.toString();
  }
}

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        User? user = userCredential.user;

        // Check if the user already exists in Firestore
        if (user != null) {
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(user.uid).get();

          if (!userDoc.exists) {
            // Add new user to Firestore
            await _firestore.collection('users').doc(user.uid).set({
              'name': googleUser.displayName ?? 'Anonymous',
              'email': user.email,
              'profile': user.photoURL,
              'created_at': FieldValue.serverTimestamp(),
            });
          }
        }

        return user;
      } else {
        throw 'Google Sign-In canceled by user';
      }
    } catch (e) {
      print('Google Sign-In error: $e');
      throw e.toString();
    }
  }


}
