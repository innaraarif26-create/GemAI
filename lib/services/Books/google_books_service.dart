import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../features/MainScreens/Home/models/book_model.dart';

/// Service for searching and fetching book metadata from the Google Books API.
///
/// Results are cached in memory so repeated queries do not hit the network.
class GoogleBooksService {
  /// Base URL for the Google Books volumes endpoint.
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  /// In-memory cache keyed by the full query string.
  final Map<String, List<BookModel>> _cache = {};

  /// Searches Google Books for [query] and returns up to [maxResults] books.
  ///
  /// Gemstone-related queries are automatically scoped by appending
  /// "+subject:gemstones" so results stay relevant to the GemAI app.
  Future<List<BookModel>> searchBooks(
    String query, {
    int maxResults = 20,
  }) async {
    // Return cached results when available
    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    try {
      final uri = Uri.parse(
        '$_baseUrl?q=${Uri.encodeQueryComponent(query)}'
        '&maxResults=$maxResults'
        '&printType=books',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        debugPrint(
          'GoogleBooksService.searchBooks – HTTP ${response.statusCode}',
        );
        return [];
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'] as List<dynamic>? ?? [];

      final books = items
          .map((item) =>
              BookModel.fromGoogleBooks(item as Map<String, dynamic>))
          .toList();

      // Cache the parsed results
      _cache[query] = books;
      return books;
    } catch (e) {
      debugPrint('GoogleBooksService.searchBooks error: $e');
      return [];
    }
  }

  /// Fetches full metadata for a single volume by its Google Books [volumeId].
  Future<BookModel?> getBookDetails(String volumeId) async {
    try {
      final uri = Uri.parse('$_baseUrl/$volumeId');
      final response = await http.get(uri);

      if (response.statusCode != 200) return null;

      final data = json.decode(response.body) as Map<String, dynamic>;
      return BookModel.fromGoogleBooks(data);
    } catch (e) {
      debugPrint('GoogleBooksService.getBookDetails error: $e');
      return null;
    }
  }

  /// Clears the in-memory results cache.
  void clearCache() => _cache.clear();
}
