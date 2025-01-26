//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Sign up function
//   Future<void> signup(String email, String password, BuildContext context) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       // After sign-up, store user data in Firestore
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': email,
//         'createdAt': Timestamp.now(),
//       });
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       _showErrorDialog(context, e.toString());
//     }
//   }
//
//   // Sign in function
//   Future<void> signin(String email, String password, BuildContext context) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       _showErrorDialog(context, e.toString());
//     }
//   }
//
//   // Sign out function
//   Future<void> signout(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushReplacementNamed(context, '/login');
//   }
//
//   // Create a new note in Firestore
//   Future<void> createNote(String title, String content) async {
//     try {
//       await _firestore.collection('notes').add({
//         'title': title,
//         'content': content,
//         'createdAt': Timestamp.now(),
//       });
//     } catch (e) {
//       print("Error creating note: $e");
//     }
//   }
//
//   // Read notes from Firestore
//   Stream<QuerySnapshot> getNotes() {
//     return _firestore.collection('notes').orderBy('createdAt', descending: true).snapshots();
//   }
//
//   // Delete note from Firestore
//   Future<void> deleteNote(String noteId) async {
//     try {
//       await _firestore.collection('notes').doc(noteId).delete();
//     } catch (e) {
//       print("Error deleting note: $e");
//     }
//   }
//
//   // Show error dialog
//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: Text("OK"),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up function
  Future<void> signup(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // After sign-up, store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': Timestamp.now(),
      });

      // Show a message and ask the user to verify email
      _showMessageDialog(context, "Please verify your email before logging in.");
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  // Sign in function with email verification check
  Future<void> signin(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Check if the user's email is verified
      if (userCredential.user?.emailVerified ?? false) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showMessageDialog(context, "Please verify your email before logging in.");
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  // Sign out function
  Future<void> signout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // Show message dialog
  void _showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
