import 'package:flutter/material.dart';
import 'package:gemai/widgets/shimmer/popular_gems_shimmer.dart';
import 'package:get/get.dart';
import '../../../../../widgets/image_text_Widget/vertical_image_text.dart';
import '../../controllers/gems_controller.dart';
import 'popular_gems_detail_screen.dart';

class AppHomePopularGemsSection extends StatelessWidget {
  const AppHomePopularGemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GemsController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const AppPopularGemsShimmer();
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.allGems.length,
          itemBuilder: (_, index) {
            final gem = controller.allGems[index];

            return AppVerticalImageText(
              image: gem.thumbImage,
              title: gem.name,
              isNetworkImage: true,
              onTap: () => Get.to(() => GemsDetailScreen(gem: gem)),
            );
          },
        ),
      );
    });
  }
}