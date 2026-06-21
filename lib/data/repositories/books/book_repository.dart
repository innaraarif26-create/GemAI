import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../features/MainScreens/Home/models/book_model.dart';
import '../../../services/Books/google_books_service.dart';

/// Repository that combines book data from local assets, Firebase Storage,
/// and the Google Books API into a single stream for the UI layer.
class BookRepository extends GetxController {
  static BookRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleBooksService _googleBooksService = GoogleBooksService();

  /// Returns all books stored in the "books" Firestore collection.
  Future<List<BookModel>> fetchFirebaseBooks() async {
    try {
      final snapshot = await _db
          .collection('books')
          .orderBy('title')
          .get();

      return snapshot.docs
          .map((doc) => BookModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching books. Please try again.';
    }
  }

  /// Searches the Google Books API for gemstone-related books.
  Future<List<BookModel>> searchGoogleBooks(String query) async {
    try {
      return await _googleBooksService.searchBooks(query);
    } catch (e) {
      debugPrint('BookRepository.searchGoogleBooks error: $e');
      return [];
    }
  }

  /// Returns the list of built-in local books bundled with the app.
  List<BookModel> getLocalBooks() {
    return [
      BookModel.fromLocal(
        id: 'local_1',
        title: 'Gemstone Identification',
        author: 'GemAI Team',
        coverAsset: 'assets/images/books/book1.jpg',
      ),
      BookModel.fromLocal(
        id: 'local_2',
        title: 'Precious Stones Guide',
        author: 'GemAI Team',
        coverAsset: 'assets/images/books/book2.png',
      ),
      BookModel.fromLocal(
        id: 'local_3',
        title: 'Gem Cutting Basics',
        author: 'GemAI Team',
        coverAsset: 'assets/images/books/book3.jpg',
      ),
      BookModel.fromLocal(
        id: 'local_4',
        title: 'World of Minerals',
        author: 'GemAI Team',
        coverAsset: 'assets/images/books/book4.jpg',
      ),
    ];
  }

  /// Combines local, Firebase, and Google Books results into one list.
  ///
  /// Local books are always shown first, followed by Firebase books,
  /// then Google Books results for the default query "gemstones".
  Future<List<BookModel>> fetchAllBooks() async {
    final List<BookModel> allBooks = [];

    // 1. Local bundled books
    allBooks.addAll(getLocalBooks());

    // 2. Firebase books (fail silently if offline)
    try {
      final firebaseBooks = await fetchFirebaseBooks();
      allBooks.addAll(firebaseBooks);
    } catch (e) {
      debugPrint('BookRepository: Firebase books unavailable – $e');
    }

    // 3. Google Books (fail silently if offline)
    try {
      final googleBooks = await searchGoogleBooks('gemstones');
      allBooks.addAll(googleBooks);
    } catch (e) {
      debugPrint('BookRepository: Google Books unavailable – $e');
    }

    return allBooks;
  }
}
