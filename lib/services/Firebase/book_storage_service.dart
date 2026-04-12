import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// Service for uploading and fetching book PDFs from Firebase Storage.
///
/// Books are stored under the `public/books/` path so they are readable
/// by all authenticated users (see Firebase Storage rules).
class BookStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Reference to the books folder in Firebase Storage.
  Reference get _booksRef => _storage.ref().child('public/books');

  /// Uploads a book PDF to Firebase Storage and returns its download URL.
  ///
  /// [file] – the local PDF file to upload.
  /// [fileName] – the name to use in storage (e.g. "gemology_101.pdf").
  Future<String> uploadBook(File file, String fileName) async {
    try {
      final ref = _booksRef.child(fileName);
      final metadata = SettableMetadata(contentType: 'application/pdf');
      await ref.putFile(file, metadata);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('BookStorageService.uploadBook error: ${e.message}');
      rethrow;
    }
  }

  /// Returns a list of download URLs for all book PDFs in storage.
  Future<List<Map<String, String>>> fetchBooksList() async {
    try {
      final ListResult result = await _booksRef.listAll();
      final List<Map<String, String>> books = [];

      for (final ref in result.items) {
        final url = await ref.getDownloadURL();
        books.add({'name': ref.name, 'url': url});
      }
      return books;
    } on FirebaseException catch (e) {
      debugPrint('BookStorageService.fetchBooksList error: ${e.message}');
      rethrow;
    }
  }

  /// Returns the download URL for a single book by its storage file name.
  Future<String> getBookUrl(String fileName) async {
    try {
      final ref = _booksRef.child(fileName);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('BookStorageService.getBookUrl error: ${e.message}');
      rethrow;
    }
  }
}
