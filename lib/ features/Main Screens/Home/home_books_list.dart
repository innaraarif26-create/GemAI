import 'package:flutter/material.dart';
import '../../../core/constants/image_strings.dart';
import '../../../widgets/books_Widget/books_container.dart';

class AppHomeBooksList extends StatelessWidget {
  const AppHomeBooksList({super.key});

  @override
  Widget build(BuildContext context) {
    final booksImages = [
      AppImages.book1,
      AppImages.book2,
      AppImages.book3,
      AppImages.book4,
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: booksImages.length,
        itemBuilder: (_, index) {
          return AppHomeBooks(
            image: booksImages[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
