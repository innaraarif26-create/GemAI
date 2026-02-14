import 'package:flutter/material.dart';
import '../../../core/constants/image_strings.dart';
import '../../../widgets/image_text_Widget/vertical_image_text.dart';

class AppStorePopularCategories extends StatelessWidget {
  const AppStorePopularCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (_, index) {
          return AppVerticalImageText(
            image: AppImages.citrine,
            title: "Precious",
            textColor: Colors.black,
            borderRadius: 8,
            backgroundColor: Color(0xFFEAEAEA),
            onTap: () {},
          );
        },
      ),
    );
  }
}