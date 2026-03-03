import 'package:flutter/material.dart';
import 'package:gemai/features/Main%20Screens/Home/popular_gems/popular_gems_detail_screen.dart';
import '../../../../models/popular_gemstone_model.dart';
import '../../../../widgets/data/popular_gems_data.dart';
import '../../../../widgets/image_text_Widget/vertical_image_text.dart';

class AppHomePopularGemsSection extends StatelessWidget {
  const AppHomePopularGemsSection({super.key});

  @override
  Widget build(BuildContext context)
  {

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: gems.length,
        itemBuilder: (_, index) {
          final gem = gems[index];
          return AppVerticalImageText(
            image: gem["image"] as String,
            title: gem["title"] as String,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => GemsDetailScreen(gem: gem["model"] as GemDetailModel),
              ),
              );
            },
          );
        },
      ),
    );
  }
}
