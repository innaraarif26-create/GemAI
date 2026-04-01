import 'package:cloud_firestore/cloud_firestore.dart';

enum FeedbackCategory { bug, featureRequest, suggestion, other }

enum FeedbackStatus { newFeedback, read, resolved }

class FeedbackModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final int? rating;
  final FeedbackCategory category;
  final DateTime createdAt;
  final FeedbackStatus status;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    this.rating,
    required this.category,
    required this.createdAt,
    this.status = FeedbackStatus.newFeedback,
  });

  static FeedbackCategory _categoryFromString(String value) {
    switch (value) {
      case 'featureRequest':
        return FeedbackCategory.featureRequest;
      case 'suggestion':
        return FeedbackCategory.suggestion;
      case 'other':
        return FeedbackCategory.other;
      default:
        return FeedbackCategory.bug;
    }
  }

  static String _categoryToString(FeedbackCategory category) {
    switch (category) {
      case FeedbackCategory.featureRequest:
        return 'featureRequest';
      case FeedbackCategory.suggestion:
        return 'suggestion';
      case FeedbackCategory.other:
        return 'other';
      case FeedbackCategory.bug:
        return 'bug';
    }
  }

  static FeedbackStatus _statusFromString(String value) {
    switch (value) {
      case 'read':
        return FeedbackStatus.read;
      case 'resolved':
        return FeedbackStatus.resolved;
      default:
        return FeedbackStatus.newFeedback;
    }
  }

  static String _statusToString(FeedbackStatus status) {
    switch (status) {
      case FeedbackStatus.read:
        return 'read';
      case FeedbackStatus.resolved:
        return 'resolved';
      case FeedbackStatus.newFeedback:
        return 'new';
    }
  }

  static String categoryLabel(FeedbackCategory category) {
    switch (category) {
      case FeedbackCategory.bug:
        return 'Bug';
      case FeedbackCategory.featureRequest:
        return 'Feature Request';
      case FeedbackCategory.suggestion:
        return 'Suggestion';
      case FeedbackCategory.other:
        return 'Other';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Title': title,
      'Message': message,
      'Rating': rating,
      'Category': _categoryToString(category),
      'CreatedAt': Timestamp.fromDate(createdAt),
      'Status': _statusToString(status),
    };
  }

  factory FeedbackModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      return FeedbackModel(
        id: document.id,
        userId: '',
        title: '',
        message: '',
        category: FeedbackCategory.other,
        createdAt: DateTime.now(),
      );
    }

    return FeedbackModel(
      id: document.id,
      userId: data['UserId'] ?? '',
      title: data['Title'] ?? '',
      message: data['Message'] ?? '',
      rating: data['Rating'] as int?,
      category: _categoryFromString(data['Category'] ?? ''),
      createdAt: (data['CreatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: _statusFromString(data['Status'] ?? ''),
    );
  }
}
