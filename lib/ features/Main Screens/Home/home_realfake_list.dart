import 'package:flutter/cupertino.dart';
import '../../../core/constants/image_strings.dart';
import '../../../widgets/RealFake_Widget/real_fake_container.dart';

class AppRealFakeList extends StatelessWidget {
  const AppRealFakeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final realFakeImages = [
      {"image": AppImages.malachite, "title": "Malachite"},
      {"image": AppImages.labradorite, "title": "Labradorite"},
      {"image": AppImages.turquoise, "title": "Turquoise"},
      {"image": AppImages.redCoral, "title": "Red Coral"},
      {"image": AppImages.citrine1, "title": "Citrine"},
      {"image": AppImages.amethyst1, "title": "Amethyst"},
      {"image": AppImages.pearl, "title": "Pearl"},
      {"image": AppImages.amber, "title": "Amber"},
      {"image": AppImages.moonstone, "title": "MoonStone"},
      {"image": AppImages.opal, "title": "Opal"},
      {"image": AppImages.gold, "title": "Gold"},
      {"image": AppImages.diamond1, "title": "Diamond"},
      {"image": AppImages.fluorite, "title": "Fluorite"},
    ];
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: realFakeImages.length > 4 ? 5 :realFakeImages.length,
        itemBuilder: (_, index) {
          return AppHomeRealFakeList(
            backgroundColor: Color.fromARGB(255, 239, 239, 239),
            image: realFakeImages[index]["image"]!,
            title: realFakeImages[index]["title"]!,
            onTap: (){},
          );
        },
      ),
    );
  }
}
