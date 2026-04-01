import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/feedback_model.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;
  String? get currentUserEmail => _auth.currentUser?.email;

  Future<bool> submitFeedback(FeedbackModel feedback) async {
    try {
      await _firestore.collection('feedbacks').add(feedback.toMap());
      return true;
    } catch (e) {
      debugPrint('FeedbackService: Error submitting feedback: $e');
      return false;
    }
  }
}
