import 'package:flutter/material.dart';
import '../../../../widgets/books_Widget/books_container.dart';
import '../../../../widgets/data/books_data.dart';

class AppHomeBooksList extends StatelessWidget {
  const AppHomeBooksList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeBooksList.length,
        itemBuilder: (_, index) {
          return AppHomeBooks(
            image: homeBooksList[index]['image']!,
            onTap: () {},
          );
        },
      ),
    );
  }
}
