import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../widgets/appbar/appbar.dart';
import '../../controllers/book_controller.dart';
import '../../models/book_model.dart';
import 'book_viewer_screen.dart';

/// Screen that displays all books in a grid layout with search capability.
///
/// The user can search Google Books via the top search bar. Local and
/// Firebase books are always visible in the main grid.
class AllBooksScreen extends StatelessWidget {
  const AllBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookController.instance;
    final bool dark = AppHelperFunctions.isDarkMode(context);
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.grey.shade50,
      appBar: AppAppBar(
        title: Text(
          'All Books',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: TextField(
              controller: searchController,
              onSubmitted: (query) => controller.searchBooks(query),
              style: TextStyle(color: dark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Search Google Books...',
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  color: AppColors.buttonSecondary,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    controller.clearSearch();
                  },
                ),
                filled: true,
                fillColor: dark ? Colors.grey[900] : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: dark ? Colors.grey[800]! : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: dark ? Colors.grey[800]! : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.buttonSecondary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          // Book grid
          Expanded(
            child: Obx(() {
              // Show search results when available
              if (controller.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.searchResults.isNotEmpty) {
                return _buildBookGrid(
                  context,
                  controller.searchResults,
                  dark,
                );
              }

              // Default: show all books
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.allBooks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No books found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              }

              return _buildBookGrid(context, controller.allBooks, dark);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBookGrid(
    BuildContext context,
    List<BookModel> books,
    bool dark,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: books.length,
      itemBuilder: (_, index) {
        final book = books[index];
        return _BookGridCard(book: book, dark: dark);
      },
    );
  }
}

/// A single book card displayed in the grid.
class _BookGridCard extends StatelessWidget {
  final BookModel book;
  final bool dark;

  const _BookGridCard({required this.book, required this.dark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BookViewerScreen(book: book)),
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dark ? Colors.grey[800]! : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: _buildCoverImage(),
              ),
            ),

            // Title and author
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Source badge
                  const SizedBox(height: 4),
                  _buildSourceBadge(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    if (book.source == BookSource.local) {
      return Image.asset(
        book.coverUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    if (book.coverUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: book.coverUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => _placeholder(),
        errorWidget: (_, __, ___) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.menu_book, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildSourceBadge(BuildContext context) {
    String label;
    Color color;

    switch (book.source) {
      case BookSource.local:
        label = 'Local';
        color = AppColors.buttonSecondary;
        break;
      case BookSource.firebase:
        label = 'Cloud';
        color = Colors.blue;
        break;
      case BookSource.googleBooks:
        label = 'Google';
        color = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
