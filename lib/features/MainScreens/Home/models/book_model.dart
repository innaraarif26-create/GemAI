/// BookModel represents a book from either Firebase Storage or Google Books API.
///
/// This model unifies data from multiple sources so the UI layer can display
/// books regardless of their origin (local assets, Firebase, or Google Books).
class BookModel {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String? pdfUrl;
  final String? previewLink;
  final String? description;
  final BookSource source;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    this.pdfUrl,
    this.previewLink,
    this.description,
    this.source = BookSource.local,
  });

  /// Creates a BookModel from a Firestore document map.
  factory BookModel.fromFirestore(Map<String, dynamic> json, String docId) {
    return BookModel(
      id: docId,
      title: json['title'] as String? ?? 'Untitled',
      author: json['author'] as String? ?? 'Unknown',
      coverUrl: json['coverUrl'] as String? ?? '',
      pdfUrl: json['pdfUrl'] as String? ?? '',
      description: json['description'] as String?,
      source: BookSource.firebase,
    );
  }

  /// Creates a BookModel from a Google Books API volume JSON object.
  factory BookModel.fromGoogleBooks(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>? ?? {};
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
    final authors = volumeInfo['authors'] as List<dynamic>?;

    return BookModel(
      id: json['id'] as String? ?? '',
      title: volumeInfo['title'] as String? ?? 'Untitled',
      author: authors != null && authors.isNotEmpty
          ? authors.join(', ')
          : 'Unknown',
      coverUrl: imageLinks?['thumbnail'] as String? ?? '',
      previewLink: volumeInfo['previewLink'] as String?,
      description: volumeInfo['description'] as String?,
      source: BookSource.googleBooks,
    );
  }

  /// Creates a BookModel from local asset data (used for built-in books).
  factory BookModel.fromLocal({
    required String id,
    required String title,
    required String author,
    required String coverAsset,
    String? pdfAsset,
  }) {
    return BookModel(
      id: id,
      title: title,
      author: author,
      coverUrl: coverAsset,
      pdfUrl: pdfAsset,
      source: BookSource.local,
    );
  }

  /// Converts the model to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'pdfUrl': pdfUrl ?? '',
      'description': description ?? '',
      'source': source.name,
    };
  }
}

/// Indicates where a book was loaded from.
enum BookSource { local, firebase, googleBooks }
