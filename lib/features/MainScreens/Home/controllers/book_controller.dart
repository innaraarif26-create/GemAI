import 'package:get/get.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/repositories/books/book_repository.dart';
import '../../../../services/Books/google_books_service.dart';
import '../models/book_model.dart';

/// GetX controller that manages the book list state for the home screen
/// and the "All Books" screen.
///
/// On initialisation it loads local + Firebase + Google Books results.
/// A separate [searchBooks] method lets the user search Google Books
/// for additional titles.
class BookController extends GetxController {
  static BookController get instance => Get.find();

  final BookRepository _bookRepository = BookRepository();
  final GoogleBooksService _googleBooksService = GoogleBooksService();

  /// The combined list of books displayed on the home screen.
  final RxList<BookModel> allBooks = <BookModel>[].obs;

  /// Books returned by the latest Google Books search.
  final RxList<BookModel> searchResults = <BookModel>[].obs;

  /// True while the initial book list is loading.
  final RxBool isLoading = false.obs;

  /// True while a Google Books search is in progress.
  final RxBool isSearching = false.obs;

  /// Stores the last error message (empty when there is no error).
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchAllBooks();
    super.onInit();
  }

  /// Fetches books from all sources (local, Firebase, Google Books).
  Future<void> fetchAllBooks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final books = await _bookRepository.fetchAllBooks();
      allBooks.assignAll(books);
    } catch (e) {
      errorMessage.value = e.toString();
      AppLoaders.errorSnackBar(
        title: 'Could not load books',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Searches Google Books for [query] and stores results in [searchResults].
  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      final results = await _googleBooksService.searchBooks(query);
      searchResults.assignAll(results);
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: 'Search failed',
        message: e.toString(),
      );
    } finally {
      isSearching.value = false;
    }
  }

  /// Clears search results and resets the searching flag.
  void clearSearch() {
    searchResults.clear();
    isSearching.value = false;
  }
}
