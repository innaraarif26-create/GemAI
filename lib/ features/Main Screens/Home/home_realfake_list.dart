import 'package:flutter/material.dart';
import '../../../core/constants/image_strings.dart';
import '../../../models/real_fake_gem_model.dart';
import '../../../widgets/RealFake_Widget/real_fake_container.dart';
import '../realfake_gems/real_fake_detail_screen.dart';

class AppRealFakeList extends StatelessWidget {
  const AppRealFakeList({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> realFakeImages = [

      {
        "image": AppImages.malachite,
        "title": "Malachite",
        "model": RealFakeGem(
          name: "Malachite",
          image: AppImages.malachite,
          description:
          "A copper carbonate hydroxide mineral, malachite is well known for its distinctive green shading, which renders it an attractive carving material. It has been mined in modern day Great Britain and Israel for over three thousand years. Until 1800, it was used as a pigment in green paints.\nPlastic, resin or clay can be shaped and dyed like polished malachite (these materials are not stone).\nThe main differences between real and fake Malachite are illustrated in the table below:",
          overviewReal:
          "Real Malachite comes in a range of greens from light to dark, but not black. Note the soft layers and uneven patterns.",
          overviewFake:
          "Plastic, resin or clay stone can bs shaped and dyed like polished malachite",
          colorReal:
          "Real malachite has a surprising amount of green. Unique patterns of swirls, rings, waves and stripes are distributed throughout the stone face.",
          colorFake:
          "Rough black lines and uniform linear patterns.",
          touchReal: "Cold to the touch for real malachite.",
          touchFake: "Warm to the touch in the case of plastic stones. Cold to the touch in the case of glass but for the first second only.",
          gravityReal: "Real malachite is heavy due to its high copper content (3.6 – 4.0 SG). This density makes it noticeably heavier than many fake imitations made from plastic, resin, or clay.",
          gravityFake: "Fake malachite is usually very light because it is made from plastic, resin, or clay. It lacks the natural copper content and density of real malachite.",
          acidReal: "If you place a drop of hydrochloric acid on powdered malachite, a visible fizz will occur.",
          acidFake: "Imitations created from plastic or glass won't produce a fizz with a drop of hydrochloric acid.",
        ),
      },

      {
        "image": AppImages.labradorite,
        "title": "Labradorite",
        "model": RealFakeGem(
          name: "Labradorite",
          image: AppImages.labradorite,
          description:
          "Labradorite is a feldspar mineral known for its remarkable play of color, called labradorescence. It is mostly found in Canada, Finland, Madagascar, and Russia. Synthetic or imitation stones may look similar but lack the unique iridescent flashes.\nThe main differences between real and fake Labradorite are illustrated in the table below:",

          overviewReal:
          "Real Labradorite shows a unique iridescence with flashes of blue, green, gold, or orange when rotated under light.",

          overviewFake:
          "Fake Labradorite lacks the natural iridescent flashes. It may have painted surfaces or plastic imitations.",

          colorReal:
          "Real Labradorite exhibits flashes of multiple colors depending on the angle of light. The colors appear vibrant and naturally blended.",

          colorFake:
          "Fake stones usually have flat, dull, or painted colors without the natural play-of-light effect.",

          touchReal:
          "Real Labradorite feels cool, dense, and solid to the touch.",

          touchFake:
          "Fake stones may feel warm or lightweight, especially if made from plastic or resin.",

          gravityReal:
          "Real Labradorite has a specific gravity of about 2.68 – 2.72, giving it a noticeable weight in the hand.",

          gravityFake:
          "Fake Labradorite often feels unusually light because it is made from synthetic materials.",

          acidReal:
          "Labradorite does not react with mild acids and maintains its surface integrity.",

          acidFake:
          "Plastic or resin imitations may show surface damage or dullness when exposed to chemicals.",

          ),
      },

      {"image": AppImages.turquoise, "title": "Turquoise"},
      {"image": AppImages.redCoral, "title": "Red Coral"},
      {"image": AppImages.citrine1, "title": "Citrine"},
      {"image": AppImages.amethyst1, "title": "Amethyst"},
      {"image": AppImages.pearl, "title": "Pearl"},
      {"image": AppImages.amber, "title": "Amber"},

      {
        "image": AppImages.moonstone,
        "title": "MoonStone",
        "model": RealFakeGem(
          name: "Moonstone",
          image: AppImages.moonstone,
          description:
          "Moonstone is known for its glowing adularescence effect.",
          overviewReal:
          "Soft pearly sheen and slight translucency.",
          overviewFake:
          "Overly transparent or lacks shimmer.",
          colorReal:
          "White, peach, gray, bluish glow.",
          colorFake:
          "Too bright or unnatural colors.",
          touchReal: "Cool to touch.",
          touchFake: "Plastic warm, glass heavier.",
          gravityReal: "Density 2.55–2.60.",
          gravityFake: "Plastic lighter, glass heavier.", acidReal: '', acidFake: '',
         ),
      },

      {"image": AppImages.opal, "title": "Opal"},
      {"image": AppImages.gold, "title": "Gold"},
      {"image": AppImages.diamond1, "title": "Diamond"},
      {"image": AppImages.fluorite, "title": "Fluorite"},
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: realFakeImages.length > 4 ? 5 : realFakeImages.length,
        itemBuilder: (_, index) {

          final gem = realFakeImages[index];

          return AppHomeRealFakeList(
            backgroundColor: const Color.fromARGB(255, 239, 239, 239),
            image: gem["image"],
            title: gem["title"],

            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RealFakeDetailScreen(
                      gem: gem["model"],
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }
}