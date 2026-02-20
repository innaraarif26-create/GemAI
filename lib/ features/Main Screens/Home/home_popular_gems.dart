import 'package:flutter/material.dart';
import '../../../core/constants/image_strings.dart';
import '../../../models/gemstone_model.dart';
import '../../../widgets/image_text_Widget/vertical_image_text.dart';
import '../popular_gems/popular_gems.dart';

class AppHomePopularGems extends StatelessWidget {
  const AppHomePopularGems({super.key});

  @override
  Widget build(BuildContext context) {
    final gems = [
      {
        "image": AppImages.diamond,
        "title": "Diamond",
        "model": GemDetailModel(
          name: "Diamond",
          image: AppImages.diamondBg,
          prices: [
            PriceInfo(quality: "Top", price: "\$5000 – \$10000"),
            PriceInfo(quality: "Good", price: "\$2000 – \$5000"),
            PriceInfo(quality: "Fair", price: "\$500 – \$2000"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "D-F colors most valued",),
            QualityFactor(title: "Clarity", description: "Flawless or VS"),
            QualityFactor(title: "Cut", description: "Excellent cuts preferred",),
          ],
          origins: ["South Africa", "Botswana", "Russia", "Canada"],
          imitations: [
            ImitationItem(
              img: AppImages.cubicZirconia,
              title: "Cubic Zirconia",
              desc: "Common imitation",
            ),
          ],
          history: [
            "Symbol of love",
            "Ancient engagement stones",
            "Used in royal jewelry",
          ],
          care: ["Clean with mild soap", "Avoid scratches", "Store separately"],
          uses: ["Rings", "Necklaces", "Bracelets"],
          buyingTips: [
            "Check color and clarity",
            "Ensure certified",
            "Compare prices",
          ],
        ),
      },
      {
        "image": AppImages.aquamarine,
        "title": "Aquamarine",
        "model": GemDetailModel(
          name: "Aquamarine",
          image: AppImages.aquamarineBg,
          prices: [
            PriceInfo(quality: "Top", price: "\$200 – \$600"),
            PriceInfo(quality: "Good", price: "\$50 – \$200"),
            PriceInfo(quality: "Fair", price: "\$20 – \$50"),
          ],
          qualityFactors: [
            QualityFactor(
              title: "Color",
              description: "Intense sea-blue shades",
            ),
            QualityFactor(
              title: "Clarity",
              description: "Transparent stones with minimal inclusions",
            ),
            QualityFactor(
              title: "Cut",
              description: "Faceted cuts enhance sparkle",
            ),
            QualityFactor(
              title: "Treatment",
              description: "Often heat-treated",
            ),
          ],
          origins: ["Brazil", "Pakistan", "Nigeria", "Madagascar"],
          imitations: [
            ImitationItem(
              img: AppImages.blueGlass,
              title: "Blue Glass",
              desc: "Soft imitation",
            ),
            ImitationItem(
              img: AppImages.berylGreen,
              title: "Green Beryl",
              desc: "Dyed beryl resembles Aquamarine",
            ),
          ],
          history: [
            "Protects sailors",
            "Used in ancient Rome",
            "Symbol of tranquility",
            "Birthstone for March",
          ],
          care: [
            "Mild soap and water",
            "Avoid harsh chemicals",
            "Store separately",
          ],
          uses: ["Jewelry", "Healing Crystal", "Decorative items"],
          buyingTips: [
            "Check color",
            "Look for clarity",
            "Cut matters",
            "Know origin",
            "Watch treatments",
            "Beware imitations",
          ],
        ),
      },
      {
        "image": AppImages.ruby,
        "title": "Ruby",
        "model": GemDetailModel(
          name: "Ruby",
          image: AppImages.rubyBg,
          prices: [
            PriceInfo(quality: "Top", price: "\$1000 – \$5000"),
            PriceInfo(quality: "Good", price: "\$300 – \$1000"),
            PriceInfo(quality: "Fair", price: "\$50 – \$300"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Deep red most valued"),
            QualityFactor(
              title: "Clarity",
              description: "Few inclusions preferred",
            ),
            QualityFactor(title: "Cut", description: "Brilliant cuts"),
            QualityFactor(
              title: "Treatment",
              description: "Heat-treated common",
            ),
          ],
          origins: ["Myanmar", "Thailand", "Sri Lanka", "Mozambique"],
          imitations: [
            ImitationItem(
              img: AppImages.glassRed,
              title: "Glass Ruby",
              desc: "Artificial imitation",
            ),
          ],
          history: [
            "Symbol of passion",
            "Royal gemstones",
            "Protective amulet",
          ],
          care: [
            "Avoid harsh chemicals",
            "Store separately",
            "Clean with mild soap",
          ],
          uses: ["Rings", "Necklaces", "Jewelry items"],
          buyingTips: [
            "Check color saturation",
            "Check clarity",
            "Buy certified stones",
          ],
        ),
      },
      // Add more gems similarly...
    ];

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
