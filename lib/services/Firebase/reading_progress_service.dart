import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Tracks per-user reading progress in Firestore.
///
/// Each document lives at `reading_progress/{userId}_{bookId}` and stores
/// the current page, total pages, and a server-side timestamp.
class ReadingProgressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Firestore collection name for reading progress documents.
  static const String _collection = 'reading_progress';

  /// Builds a deterministic document ID from user and book identifiers.
  String _docId(String userId, String bookId) => '${userId}_$bookId';

  /// Saves (or updates) the current reading position for a given book.
  ///
  /// Called automatically every time the user changes page in the viewer.
  Future<void> saveProgress({
    required String userId,
    required String bookId,
    required int currentPage,
    required int totalPages,
  }) async {
    try {
      await _db.collection(_collection).doc(_docId(userId, bookId)).set({
        'userId': userId,
        'bookId': bookId,
        'currentPage': currentPage,
        'totalPages': totalPages,
        'lastReadTime': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('ReadingProgressService.saveProgress error: $e');
    }
  }

  /// Retrieves the saved reading progress for a book.
  ///
  /// Returns `null` if no progress exists yet.
  Future<ReadingProgress?> getProgress({
    required String userId,
    required String bookId,
  }) async {
    try {
      final doc = await _db
          .collection(_collection)
          .doc(_docId(userId, bookId))
          .get();

      if (!doc.exists || doc.data() == null) return null;
      return ReadingProgress.fromFirestore(doc.data()!);
    } catch (e) {
      debugPrint('ReadingProgressService.getProgress error: $e');
      return null;
    }
  }

  /// Returns all reading-progress documents for the given user,
  /// ordered by the most recently read first.
  Future<List<ReadingProgress>> getUserProgress(String userId) async {
    try {
      final snapshot = await _db
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('lastReadTime', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReadingProgress.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('ReadingProgressService.getUserProgress error: $e');
      return [];
    }
  }
}

/// Plain data class representing a single reading-progress record.
class ReadingProgress {
  final String userId;
  final String bookId;
  final int currentPage;
  final int totalPages;
  final DateTime? lastReadTime;

  const ReadingProgress({
    required this.userId,
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    this.lastReadTime,
  });

  /// Percentage of the book that has been read (0.0 – 1.0).
  double get progressPercent =>
      totalPages > 0 ? currentPage / totalPages : 0.0;

  factory ReadingProgress.fromFirestore(Map<String, dynamic> json) {
    return ReadingProgress(
      userId: json['userId'] as String? ?? '',
      bookId: json['bookId'] as String? ?? '',
      currentPage: json['currentPage'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      lastReadTime: (json['lastReadTime'] as Timestamp?)?.toDate(),
    );
  }
}
