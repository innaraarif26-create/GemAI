import 'package:flutter/cupertino.dart';
import '../../../core/constants/image_strings.dart';
import '../../../widgets/image_text_Widget/vertical_image_text.dart';

class AppHomePopularGems extends StatelessWidget {
  const AppHomePopularGems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return AppVerticalImageText(image: AppImages.emerald, title: 'Diamond',onTap: (){},);
        },
      ),
    );
  }
}