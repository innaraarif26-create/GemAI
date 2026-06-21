import 'package:cached_network_image/cached_network_image.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../core/constants/sizes.dart';
import '../../features/MainScreens/Home/models/book_model.dart';

/// Displays a single book card in the horizontal home-screen list.
///
/// Shows the cover image, title, and author. Supports local asset images
/// as well as network images from Firebase Storage or Google Books.
class AppHomeBooks extends StatelessWidget {
  const AppHomeBooks({
    super.key,
    required this.image,
    this.title,
    this.author,
    this.source = BookSource.local,
    this.onTap,
  });

  final String image;
  final String? title;
  final String? author;
  final BookSource source;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.bookWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Container(
              height: AppSizes.bookHeight,
              width: AppSizes.bookWidth,
              margin: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.xs),
                border: Border.all(
                  color: dark ? Colors.white : Colors.grey.shade400,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.xs),
                child: _buildImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Picks the right image widget based on the book source.
  Widget _buildImage() {
    if (source == BookSource.local) {
      return Image.asset(image, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder());
    }

    // Network images (Firebase or Google Books)
    if (image.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: image,
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
        child: Icon(Icons.menu_book, size: 28, color: Colors.grey),
      ),
    );
  }
}