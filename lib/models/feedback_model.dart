class FeedbackModel {
  final String? id;
  final String userId;
  final String email;
  final String feedbackText;
  final int rating;
  final DateTime createdAt;

  FeedbackModel({
    this.id,
    required this.userId,
    required this.email,
    required this.feedbackText,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'feedbackText': feedbackText,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      feedbackText: map['feedbackText'] ?? '',
      rating: map['rating'] ?? 0,
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) ?? DateTime.now() : DateTime.now(),
    );
  }
}
