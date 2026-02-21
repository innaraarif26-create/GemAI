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
          "A copper carbonate mineral known for its green bands and swirls.",
          overviewReal:
          "Real malachite ranges from light to dark green but never black.",
          overviewFake:
          "Plastic or resin may be dyed to look like malachite.",
          colorReal:
          "Natural swirls, rings, and bands with multiple green shades.",
          colorFake:
          "Uniform lines and unnatural black streaks.",
          touchReal: "Cold to touch.",
          touchFake: "Plastic feels warm, glass feels cold briefly.",
          gravityReal: "Heavy due to copper content.",
          gravityFake: "Lightweight due to plastic or resin.",
          extraTitle: "Acid Test",
          extraReal: "Produces fizz when acid is applied.",
          extraFake: "No reaction.",
        ),
      },

      {"image": AppImages.labradorite, "title": "Labradorite"},
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
          gravityFake: "Plastic lighter, glass heavier.",
          extraTitle: "Inclusions",
          extraReal: "Natural inclusions may appear.",
          extraFake: "Bubbles or repetitive patterns.",
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