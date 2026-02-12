import 'package:flutter/cupertino.dart';
import '../../../core/constants/image_strings.dart';
import '../../../widgets/image_text_Widget/vertical_image_text.dart';

class AppHomePopularGems extends StatelessWidget {
  const AppHomePopularGems({super.key});

  @override
  Widget build(BuildContext context) {

    final gems = [
      {"image": AppImages.diamond, "title": "Diamond"},
      {"image": AppImages.amethyst, "title": "Amethyst"},
      {"image": AppImages.tanzanite, "title": "Tanzanite"},
      {"image": AppImages.citrine, "title": "Citrine"},
      {"image": AppImages.emerald, "title": "Emerald"},
      {"image": AppImages.ruby, "title": "Ruby"},
      {"image": AppImages.aquamarine, "title": "Aquamarine"},
      {"image": AppImages.sapphire, "title": "Sapphire"},
      {"image": AppImages.morganite, "title": "Morganite"},
      {"image": AppImages.topaz, "title": "Topaz"},
      {"image": AppImages.peridot, "title": "Peridot"},
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: gems.length,
        itemBuilder: (_, index) {
          return AppVerticalImageText(
            image: gems[index]["image"]!,
            title: gems[index]["title"]!,
            onTap: () {},
          );
        },
      ),
    );
  }
}
