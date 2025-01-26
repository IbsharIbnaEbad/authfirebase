// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CrudService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Create a note in Firestore
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
//   // Delete a note from Firestore
//   Future<void> deleteNote(String noteId) async {
//     try {
//       await _firestore.collection('notes').doc(noteId).delete();
//     } catch (e) {
//       print("Error deleting note: $e");
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a note in Firestore
  Future<void> createNote(String title, String content) async {
    try {
      await _firestore.collection('notes').add({
        'title': title,
        'content': content,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print("Error creating note: $e");
    }
  }

  // Update a note in Firestore
  Future<void> updateNote(String noteId, String title, String content) async {
    try {
      await _firestore.collection('notes').doc(noteId).update({
        'title': title,
        'content': content,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  // Delete a note from Firestore
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  // Read notes from Firestore
  Stream<QuerySnapshot> getNotes() {
    return _firestore.collection('notes').orderBy('createdAt', descending: true).snapshots();
  }
}
