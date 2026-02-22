import 'package:flutter/material.dart';
import 'package:GemAI/%20features/Main%20Screens/Home/realfake_gems/real_fake_detail_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../widgets/RealFake_Widget/real_fake_container.dart';
import '../../../../widgets/data/real_fake_gems_data.dart';

class AppHomeRealFakeSection extends StatelessWidget {
  const AppHomeRealFakeSection({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: realFakeGems.length > 4 ? 5 : realFakeGems.length,
        itemBuilder: (_, index) {

          final gem = realFakeGems[index];

          return AppHomeRealFakeList(
            backgroundColor: const Color.fromARGB(255, 239, 239, 239),
            image: gem["image"],
            title: gem["title"],

              onTap: () => Get.to(() => RealFakeDetailScreen(gem: gem["model"],
              ),
              ),
          );
        },
      ),
    );
  }
}