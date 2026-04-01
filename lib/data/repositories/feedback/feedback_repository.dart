import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/format_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../features/personalization/models/feedback_model.dart';

class FeedbackRepository extends GetxController {
  static FeedbackRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save a new feedback entry to Firestore.
  Future<void> submitFeedback(FeedbackModel feedback) async {
    try {
      await _db.collection('feedback').add(feedback.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Stream of feedback entries submitted by a specific user.
  Stream<List<FeedbackModel>> getUserFeedback(String userId) {
    return _db
        .collection('feedback')
        .where('UserId', isEqualTo: userId)
        .orderBy('CreatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FeedbackModel.fromSnapshot(doc))
            .toList());
  }

  /// Returns the total number of feedback entries submitted by a specific user.
  Future<int> getFeedbackStats(String userId) async {
    try {
      final snapshot = await _db
          .collection('feedback')
          .where('UserId', isEqualTo: userId)
          .count()
          .get();
      return snapshot.count ?? 0;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
