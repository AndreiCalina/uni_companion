// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch user data from Firestore
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      // Fetch user document from the 'users' collection
      DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();

      // Check if the document exists
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
