import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/data/articles_data.dart';
import '../../../../widgets/data/books_data.dart';
import '../../../../widgets/data/real_fake_gems_data.dart';
import '../models/search_result_model.dart';
import 'gems_controller.dart';

class GemSearchController extends GetxController {
  static GemSearchController get instance => Get.find();

  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxList<SearchResult> searchResults = <SearchResult>[].obs;

  final TextEditingController textController = TextEditingController();

  final List<String> categories = ['All', 'Gems', 'Books', 'Articles', 'Real/Fake'];

  List<SearchResult> _buildAllItems() {
    final List<SearchResult> items = [];

    // Popular Gems from GemsController
    try {
      final gemsController = Get.find<GemsController>();
      for (final gem in gemsController.allGems) {
        items.add(SearchResult(
          title: gem.name,
          image: gem.thumbImage,
          category: 'Gems',
          isNetworkImage: true,
          data: gem,
        ));
      }
    } catch (_) {}

    // Books
    for (final book in homeBooksList) {
      items.add(SearchResult(
        title: book['title']!,
        image: book['image']!,
        category: 'Books',
        data: book,
      ));
    }

    // Articles
    for (final article in articles) {
      items.add(SearchResult(
        title: article['title']!,
        image: article['image']!,
        category: 'Articles',
        data: article,
      ));
    }

    // Real vs Fake Gems
    for (final gem in realFakeGems) {
      items.add(SearchResult(
        title: gem['title'] as String,
        image: gem['image'] as String,
        category: 'Real/Fake',
        data: gem['model'],
      ));
    }

    return items;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _filterResults();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    _filterResults();
  }

  void _filterResults() {
    final query = searchQuery.value.toLowerCase().trim();
    final category = selectedCategory.value;

    if (query.isEmpty && category == 'All') {
      searchResults.clear();
      return;
    }

    searchResults.assignAll(
      _buildAllItems().where((item) {
        final matchesCategory = category == 'All' || item.category == category;
        final matchesQuery =
            query.isEmpty || item.title.toLowerCase().contains(query);
        return matchesCategory && matchesQuery;
      }).toList(),
    );
  }

  void clearSearch() {
    textController.clear();
    searchQuery.value = '';
    selectedCategory.value = 'All';
    searchResults.clear();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
