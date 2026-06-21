import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/books_Widget/books_container.dart';
import '../../Home/controllers/book_controller.dart';
import '../../Home/models/book_model.dart';
import '../../Home/screens/Books/book_viewer_screen.dart';

/// Horizontal book list shown on the home screen.
///
/// Displays books from the [BookController] which combines local assets,
/// Firebase Storage, and Google Books API results.
class AppHomeBooksList extends StatelessWidget {
  const AppHomeBooksList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();

    return SizedBox(
      height: 160,
      child: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error / empty state
        if (controller.allBooks.isEmpty) {
          return Center(
            child: Text(
              'No books available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.allBooks.length,
          itemBuilder: (_, index) {
            final BookModel book = controller.allBooks[index];
            return AppHomeBooks(
              image: book.coverUrl,
              title: book.title,
              author: book.author,
              source: book.source,
              onTap: () => Get.to(() => BookViewerScreen(book: book)),
            );
          },
        );
      }),
    );
  }
}

