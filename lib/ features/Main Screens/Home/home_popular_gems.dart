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
            PriceInfo(quality: "High Quality", price: "\$5000 – \$10000 per carat"),
            PriceInfo(quality: "Medium Quality", price: "\$2000 – \$5000 per carat"),
            PriceInfo(quality: "Low Quality:", price: "\$500 – \$2000 per carat"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Graded from D (colorless) to Z (light yellow/brown). Less color usually means higher value.",),
            QualityFactor(title: "Clarity", description: "Measures the presence of internal or external imperfections (inclusions or blemishes)."),
            QualityFactor(title: "Cut", description: "Determines the diamond's brilliance and sparkle. Excellent cuts reflect light perfectly.",),
            QualityFactor(title: "Carat", description: "Refers to the weight of the diamond. Higher carat usually means larger size and higher price."),

          ],
          origins: ["South Africa:", "Botswana", "Russia", "Canada"],
          imitations: [
            ImitationItem(img: AppImages.cubicZirconia, title: "Cubic Zirconia", desc: "Synthetic, cheaper and less hard than a real diamond.\n",),
            ImitationItem(img: AppImages.moissanite, title: "Moissanite", desc: "Lab-created gemstone resembling diamond in brilliance but slightly softer.\n",),
            ImitationItem(img: AppImages.whiteSapphire, title: "White Sapphire", desc: "Natural gemstone that mimics diamond but lacks sparkle and hardness.\n",),
            ImitationItem(img: AppImages.glass, title: "Glass or Crystal", desc: "Low-cost imitations that are very soft and fragile.",),
          ],
          history: [
            "Diamonds have fascinated humans for thousands of years. They were first discovered in India around 4th century BC, where they were valued as religious icons and symbols of wealth and power.\n",
            "During the Middle Ages, diamonds were believed to have mystical powers, such as protecting warriors in battle and bringing courage to their owners.\n",
            "In modern times, diamonds became symbols of love and commitment, especially with the rise of diamond engagement rings in the 20th century.\n",
            "Legend & Lore: Diamonds were thought to bring clarity, strength, and invincibility. Some myths even claimed that diamonds could absorb negative energy or evil spirits.\n",
          ],
          care: [
            "Clean your diamond jewelry regularly using warm water, mild dish soap, and a soft brush. Avoid harsh chemicals.\n",
            "Even though diamonds are hard, their settings (metal prongs) can get scratched or loosened by abrasive materials.\n",
            "Store diamond jewelry separately in soft cloth or padded jewelry boxes to prevent scratches from other jewelry"
          ],

          uses: [
            "Engagement rings, necklaces, earrings, and luxury items.",
            "Cutting tools, drills, and high-precision equipment.",
            "Used in lasers, electronics, and semiconductors due to hardness and thermal conductivity."
          ],

          buyingTips: [
            "Check Cut, Color, Clarity, Carat.",
            "Always ensure the diamond is certified.",
            "Check across reputable jewelers for the best value.",
          ],
        ),
      },


      {
        "image": AppImages.amethyst,
        "title": "Amethyst",
        "model": GemDetailModel(
          name: "Amethyst",
          image: AppImages.amethystBg,
          prices: [
            PriceInfo(quality: "High Quality", price: "\$20 – \$40 per carat"),
            PriceInfo(quality: "Medium Quality", price: "\$5 – \$15 per carat"),
            PriceInfo(quality: "Low Quality", price: "\$1 – \$5 per carat"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Deep purple with red or blue flashes is highest quality.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones increase value.",),
            QualityFactor(title: "Cut", description: "Well-cut stones reflect light better.",),
            QualityFactor(title: "Origin", description: "Siberian & African stones have richest colors.",),
          ],
          origins: ["Brazil", "Uruguay", "Zambia", "Russia (Siberia)"],
          imitations: [
            ImitationItem(img: AppImages.amethystGlass, title: "Glass", desc: "Common imitation with low hardness and weaker color.\n",),
            ImitationItem(img: AppImages.amethystSynthetic, title: "Synthetic Amethyst", desc: "Lab-grown versions that look identical but cost much less.\n",),
            ImitationItem(img: AppImages.amethystQuartz, title: "Dyed Quartz", desc: "Quartz dyed purple to mimic Amethyst.\n",),
            ImitationItem(img: AppImages.amethystPaste, title: "Glass Paste", desc: "Soft glass imitation used in low-cost jewelry.",),
          ],
          history: [
            "Ancient Greeks believed Amethyst protected from drunkenness.",
            "In medieval Europe it symbolized royalty.",
            "February birthstone symbolizing calmness and clarity.",
          ],
          care: [
            "Avoid prolonged sunlight (color may fade).",
            "Clean with mild soap and warm water.",
            "Store away from harder stones.",
          ],
          uses: [
            "Jewelry: rings, pendants, bracelets.",
            "Meditation & calmness.",
            "Crystal collections and décor.",
          ],
          buyingTips: [
            "Choose deep purple stones.",
            "Check clarity and cut.",
            "African & Siberian origins are premium.",
          ],
        ),
      },

      {
        "image": AppImages.tanzanite,
        "title": "Tanzanite",
        "model": GemDetailModel(
          name: "Tanzanite",
          image: AppImages.tanzaniteBg,
          prices: [
            PriceInfo(quality: "High Quality", price: "\$800 – \$1,500 per carat"),
            PriceInfo(quality: "Medium Quality", price: "\$400 – \$800 per carat"),
            PriceInfo(quality: "Low Quality", price: "\$20 – \$100 per carat"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Deep blue-violet is most valuable; lighter or greenish tones are less valued.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones without inclusions are preferred.",),
            QualityFactor(title: "Cut", description: "Well-cut stones enhance brilliance and pleochroism.",),
            QualityFactor(title: "Carat", description: "Larger stones with rich color are more valuable.",),
          ],
          origins: [
            "Tanzania (Merelani Hills)",
            "Rare small finds elsewhere (not commercial)"
          ],
          imitations: [
            ImitationItem(img: AppImages.blueGlass, title: "Colored Glass", desc: "Low-cost imitation lacking hardness and pleochroism.\n",),
            ImitationItem(img: AppImages.cubicZirconia, title: "Cubic Zirconia", desc: "Synthetic stone resembling Tanzanite but less vibrant."),
          ],
          history: [
            "Discovered in 1967 in Tanzania.",
            "Famous for rare vivid blue-violet color.",
            "Believed to promote calm, creativity & spiritual awareness.",
            "December birthstone and highly sought by collectors.",
          ],
          care: [
            "Clean with warm water, mild soap & soft brush.",
            "Avoid heat, chemicals & ultrasonic cleaners.",
            "Store separately to prevent scratches.",
            "Check settings regularly.",
          ],
          uses: [
            "Jewelry: rings, earrings, necklaces & bracelets.",
            "Collectors & investment due to rarity.",
            "Symbolic & spiritual uses.",
          ],
          buyingTips: [
            "Choose deep blue-violet color.",
            "Prefer eye-clean stones.",
            "Compare reputable sellers.",
            "Ask for certification.",
          ],
        ),
      },


      {
        "image": AppImages.citrine,
        "title": "Citrine",
        "model": GemDetailModel(
          name: "Citrine",
          image: AppImages.citrineBg,
          prices: [
            PriceInfo(quality: "High Quality", price: "\$30 – \$70 per carat"),
            PriceInfo(quality: "Medium Quality", price: "\$10 – \$30 per carat"),
            PriceInfo(quality: "Low Quality", price: "\$5 – \$15 per carat"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Deep orange & Madeira tones are most valuable.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones are highly valued.",),
            QualityFactor(title: "Cut", description: "Well-cut stones show more brilliance.",),
            QualityFactor(title: "Treatment", description: "Most citrine is heat-treated amethyst.",),
          ],
          origins: ["Brazil", "Madagascar", "Russia", "Zambia & Namibia"],
          imitations: [
            ImitationItem(img: AppImages.heatAmethyst, title: "Heat-treated Amethyst", desc: "Most common imitation.\n",),
            ImitationItem(img: AppImages.glassYellow, title: "Yellow Glass", desc: "Very inexpensive imitation.\n",),
            ImitationItem(img: AppImages.yellowTopaz, title: "Yellow Topaz", desc: "Often mistaken due to similar color.\n",),
          ],
          history: [
            "Used since ancient Greece.",
            "Called the Merchant’s Stone for attracting wealth.",
            "November birthstone symbolizing positivity.",
          ],
          care: [
            "Clean with mild soap and water.",
            "Avoid long sunlight exposure.",
            "Store separately to avoid scratches.",
          ],
          uses: [
            "Jewelry: rings, pendants, earrings.",
            "Feng Shui wealth stone.",
            "Boosts confidence and emotional balance.",
          ],
          buyingTips: [
            "Look for deep golden color.",
            "Natural citrine is rarer.",
            "Avoid overly pale stones.",
          ],
        ),
      },

      {
        "image": AppImages.emerald,
        "title": "Emerald",
        "model": GemDetailModel(
          name: "Emerald",
          image: AppImages.emeraldBg,
          prices: [
            PriceInfo(quality: "High Quality", price: "\$1,000 – \$8,000 per carat",),
            PriceInfo(quality: "Medium Quality", price: "\$200 – \$1,000 per carat",),
            PriceInfo(quality: "Low Quality", price: "\$50 – \$200 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Rich vivid green is most valuable.",),
            QualityFactor(title: "Clarity", description: "Slight inclusions acceptable; eye-clean stones are rare.",),
            QualityFactor(title: "Cut", description: "Well-cut stones enhance brightness and maximize color.",),
            QualityFactor(title: "Treatment", description: "Most emeralds are oiled to enhance clarity; untreated stones are more valuable.",),
          ],
          origins: [
            "Colombia", "Zambia", "Brazil", "Afghanistan", "Pakistan",
          ],
          imitations: [
            ImitationItem(img: AppImages.glassGreen, title: "Green Glass", desc: "Cheap imitation with weaker brilliance and depth.\n",),
            ImitationItem(img: AppImages.beryl, title: "Beryl", desc: "Natural stone resembling emerald but softer green.\n",),
            ImitationItem(img: AppImages.fluorite, title: "Fluorite", desc:"Low-cost imitation lacking durability and easily scratched.",),
          ],
          history: [
            "Mined in Egypt as early as 1500 BC.",
            "Believed to bring foresight, protection & love.",
            "May birthstone symbolizing growth & prosperity.",
            "Worn by royalty for centuries.",
          ],
          care: [
            "Avoid heat & harsh chemicals.",
            "Clean gently with mild soap & warm water.",
            "Store separately to protect oil treatments.",
          ],
          uses: [
            "Jewelry: rings, necklaces, bracelets, earrings.",
            "Healing & Feng Shui uses.",
            "Collector and investment gemstone.",
          ],
          buyingTips: [
            "Choose deep vivid green color.",
            "Eye-clean stones are rare but valuable.",
            "Ask about oil treatment.",
            "Compare reputable sellers.",
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
            PriceInfo(quality: "High Quality", price: "\$8,000 – \$15,000 per carat",),
            PriceInfo(quality: "Medium Quality", price: "\$300 – \$8,000 per carat",),
            PriceInfo(quality: "Low Quality", price: "\$50 – \$300 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Bright vivid red (pigeon blood red) is most valuable.",),
            QualityFactor(title: "Clarity", description: "Minor inclusions are normal; eye-clean stones are rare.",),
            QualityFactor(title: "Cut", description: "Well-cut rubies maximize brilliance and color.",),
            QualityFactor(title: "Treatment", description: "Most rubies are heat-treated; untreated stones are more valuable.",),
          ],
          origins: [
            "Myanmar (Burma)",
            "Thailand",
            "Sri Lanka",
            "Mozambique",
            "Madagascar",
          ],
          imitations: [
            ImitationItem(img: AppImages.glassRed, title: "Red Glass", desc: "Low-cost imitation lacking the brilliance of natural ruby.\n",),
            ImitationItem(img: AppImages.zirconRed, title: "Red Zircon", desc: "Natural gemstone resembling ruby but softer in color.\n",),
            ImitationItem(img: AppImages.spinel, title: "Spinel", desc: "Often mistaken for ruby; slightly softer but naturally beautiful.",),
          ],
          history: [
            "Known as the 'King of Gems' for centuries.",
            "Symbol of passion, protection, and power.",
            "Worn by royalty and warriors for courage.",
            "July birthstone representing love and vitality.",
          ],
          care: [
            "Clean with warm water and mild soap.",
            "Avoid harsh chemicals and extreme heat.",
            "Store separately to prevent scratches.",
          ],
          uses: [
            "Jewelry: rings, necklaces, bracelets, earrings.",
            "Symbolic & spiritual significance.",
            "Collector and investment gemstone.",
          ],
          buyingTips: [
            "Look for vivid pigeon blood red color.",
            "Minor inclusions are normal.",
            "Ask about heat treatment.",
            "Buy from reputable dealers.",
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
            PriceInfo(quality: "High Quality", price: "\$200 – \$600 per carat",),
            PriceInfo(quality: "Medium Quality", price: "\$50 – \$200 per carat",),
            PriceInfo(quality: "Low Quality", price: "\$20 – \$50 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Intense sea-blue shades are most valuable.",),
            QualityFactor(title: "Clarity", description: "Transparent stones with minimal inclusions are preferred.",),
            QualityFactor(title: "Cut", description: "Faceted cuts enhance sparkle and brilliance.",),
            QualityFactor(title: "Treatment", description: "Often heat-treated to remove greenish tones.",),
          ],
          origins: [
            "Brazil",
            "Pakistan",
            "Nigeria",
            "Madagascar",
          ],
          imitations: [
            ImitationItem(img: AppImages.blueGlass, title: "Blue Glass", desc: "Soft and inexpensive imitation commonly used in jewelry.\n",),
            ImitationItem(img: AppImages.berylGreen, title: "Green Beryl", desc: "Lower-quality beryl sometimes dyed to resemble aquamarine.",),
          ],
          history: [
            "Believed to protect sailors and ensure safe voyages.",
            "Popular in ancient Rome for jewelry and talismans.",
            "Associated with courage, tranquility, and clarity.",
            "March birthstone symbolizing youth and serenity.",
          ],
          care: [
            "Clean with mild soap and warm water.",
            "Avoid harsh chemicals and ultrasonic cleaners.",
            "Store separately to prevent scratches.",
          ],
          uses: [
            "Jewelry: rings, earrings, pendants, bracelets.",
            "Healing crystal believed to calm the mind.",
            "Decorative carvings and ornaments.",
          ],
          buyingTips: [
            "Deep blue or slightly greenish-blue stones are most valuable.",
            "Eye-clean stones are preferred.",
            "Well-cut stones show greater brilliance.",
            "Brazil and Madagascar produce top-quality stones.",
            "Heat treatment is common and acceptable.",
            "Beware of imitations like blue topaz or dyed quartz.",
            "Compare prices before buying.",
          ],
        ),
      },

      {
        "image": AppImages.sapphire,
        "title": "Sapphire",
        "model": GemDetailModel(
          name: "Sapphire",
          image: AppImages.sapphireBg,
          prices: [
            PriceInfo(quality: "High Quality (Royal Blue)", price: "\$1,000 – \$4,000 per carat",),
            PriceInfo(quality: "Medium Quality", price: "\$150 – \$1,000 per carat",),
            PriceInfo(quality: "Low Quality", price: "\$20 – \$150 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Deep vivid blue with uniform tone is most valuable.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones are preferred; minor inclusions are normal.",),
            QualityFactor(title: "Cut", description: "Well-cut sapphires maximize brilliance and color.",),
            QualityFactor(title: "Treatment", description: "Heat treatment is common; untreated stones are rarer and more valuable.",),
          ],
          origins: [
            "Kashmir (India)",
            "Myanmar (Burma)",
            "Sri Lanka (Ceylon)",
            "Madagascar",
            "Australia",
          ],
          imitations: [
            ImitationItem(img: AppImages.blueGlass1, title: "Blue Glass", desc: "Low-cost imitation with weaker brilliance.\n",),
            ImitationItem(img: AppImages.blueZircon, title: "Blue Zircon", desc: "Natural stone resembling sapphire but slightly softer.\n",),
            ImitationItem(img: AppImages.blueSpinel, title: "Blue Spinel", desc: "Natural gemstone often confused with sapphire but less vivid.",),
          ],
          history: [
            "Treasured for centuries as symbols of wisdom and good fortune.",
            "Worn by royalty and clergy as protective stones.",
            "Believed to attract divine favor and spiritual insight.",
            "September birthstone representing loyalty and nobility.",
          ],
          care: [
            "Clean with mild soap and warm water.",
            "Avoid harsh chemicals and ultrasonic cleaners if treated.",
            "Store separately to prevent scratches.",
            "Check settings periodically to ensure security.",
          ],
          uses: [
            "Jewelry: rings, necklaces, earrings, bracelets.",
            "Symbolic stone representing wisdom and loyalty.",
            "Collector gemstone and investment stone.",
          ],
          buyingTips: [
            "Deep vivid blue color is most valuable.",
            "Eye-clean stones are preferred.",
            "Untreated sapphires are rarer and more valuable.",
            "Compare prices from reputable jewelers.",
          ],
        ),
      },

      {
        "image": AppImages.morganite,
        "title": "Morganite",
        "model": GemDetailModel(
          name: "Morganite",
          image: AppImages.morganiteBg,
          prices: [
            PriceInfo(quality: "Hgh Quality (Vivid Pink, Eye-clean)", price: "\$300 – \$600 per carat",),
            PriceInfo(quality: "Medium Good Quality (Pink, Slight Inclusions)", price: "\$50 – \$300 per carat",),
            PriceInfo(quality: "Low Quality (Pale Pink, Heavily Included)", price: "\$10 – \$50 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Rich pink or peach hues are most desirable.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones are preferred; inclusions lower value.",),
            QualityFactor(title: "Cut", description: "Well-cut stones enhance brilliance and depth of color.",),
          ],
          origins: [
            "Brazil",
            "Mozambique",
            "Madagascar",
            "USA (California & Maine)",
          ],
          imitations: [
            ImitationItem(img: AppImages.pinkGlass, title: "Pink Glass", desc: "Low-cost imitation, lacks brilliance and hardness.\n",),
            ImitationItem(img: AppImages.pinkTopaz, title: "Pink Topaz", desc: "Natural stone resembling Morganite, slightly harder but different hue.\n",),
            ImitationItem(img: AppImages.pinkQuartz, title: "Rose Quartz", desc: "Soft, pale pink crystal mimicking Morganite but lacks depth and clarity.",),
          ],
          history: [
            "Discovered in 1910 and named after financier J.P. Morgan.",
            "Believed to bring love, compassion, and healing energy.",
            "Often given as a romantic gift due to its gentle pink hue.",
            "Alternative October birthstone, representing emotional balance and confidence.",
          ],
          care: [
            "Clean with warm water, mild soap, and soft brush.",
            "Avoid harsh chemicals and ultrasonic cleaners.",
            "Store separately to prevent scratches.",
            "Check settings periodically to ensure gemstone security.",
          ],
          uses: [
            "Jewelry: rings, necklaces, earrings, bracelets.",
            "Spiritual & Symbolic: represents love, compassion, and emotional balance.",
            "Collector gemstone and investment stone.",
          ],
          buyingTips: [
            "Vivid pink or peach color is most desirable.",
            "Eye-clean stones are preferred; slight inclusions are normal.",
            "Compare prices from multiple reputable sellers.",
            "Ask for certification to verify authenticity and treatment status.",
          ],
        ),
      },

      {
        "image": AppImages.topaz,
        "title": "Topaz",
        "model": GemDetailModel(
          name: "Topaz",
          image: AppImages.topazBg,
          prices: [
            PriceInfo(quality: "Imperial Topaz (Rich Orange/Red)", price: "\$500 – \$1,500 per carat",),
            PriceInfo(quality: "Pink Topaz", price: "\$300 – \$700 per carat",),
            PriceInfo(quality: "Blue Topaz (Swiss or London Blue)", price: "\$20 – \$100 per carat",),
            PriceInfo(quality: "Other Colors / Low Quality", price: "\$5 – \$20 per carat",),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Rich, vivid colors like imperial orange or pink are most valuable.",),
            QualityFactor(title: "Clarity", description: "Eye-clean stones without inclusions are preferred.",),
            QualityFactor(title: "Cut", description: "Well-cut stones enhance brilliance and sparkle.",),
            QualityFactor(title: "Size / Carat", description: "Larger stones of good color and clarity are highly valued.",),
          ],
          origins: [
            "Brazil",
            "Russia",
            "Pakistan",
            "USA (Utah & Texas)",
          ],
          imitations: [
            ImitationItem(
              img: AppImages.orangeGlass,
              title: "Colored Glass",
              desc: "Low-cost imitation, lacks hardness and brilliance.\n",
            ),
            ImitationItem(
              img: AppImages.cubicZirconia1,
              title: "Cubic Zirconia",
              desc: "Synthetic stone may resemble topaz in color but softer.",
            ),
          ],
          history: [
            "Topaz prized since ancient Egypt and Greece.",
            "Believed to bring protection, strength, and healing.",
            "Imperial Topaz symbolizes wealth and status.",
            "Blue topaz associated with love and fidelity.",
          ],
          care: [
            "Clean using warm water, mild soap, and soft brush.",
            "Avoid harsh chemicals and ultrasonic cleaners.",
            "Store separately to prevent scratches.",
            "Check gemstone settings regularly.",
          ],
          uses: [
            "Jewelry: rings, pendants, earrings, bracelets.",
            "Spiritual & Symbolic: believed to bring strength, protection, and healing.",
            "Collectors & Investment: high-quality imperial topaz is valuable.",
          ],
          buyingTips: [
            "Check Color: vivid colors (imperial orange, pink, blue) are most valuable.",
            "Examine Clarity: eye-clean stones are preferred.",
            "Compare Prices: check multiple reputable sellers.",
            "Certification: ask for certification to verify authenticity and treatment status.",
          ],
        ),
      },

      {
        "image": AppImages.peridot,
        "title": "Peridot",
        "model": GemDetailModel(
          name: "Peridot",
          image: AppImages.peridotBg,
          prices: [
            PriceInfo(quality: "Deep Green (High Quality)", price: "\$40 – \$120 per carat"),
            PriceInfo(quality: "Medium Green", price: "\$15 – \$40 per carat"),
            PriceInfo(quality: "Light / Yellowish Green", price: "\$5 – \$15 per carat"),
          ],
          qualityFactors: [
            QualityFactor(title: "Color", description: "Pure lime-green stones are the most valuable."),
            QualityFactor(title: "Clarity", description: "Look for eye-clean Peridot with minimal black spots."),
            QualityFactor(title: "Cut", description: "Good cutting increases brilliance and hides inclusions."),
            QualityFactor(title: "Size", description: "Large Peridot above 5 carats are rarer and pricier."),
          ],
          origins: [
            "Pakistan (Kohistan)",
            "Myanmar",
            "China",
            "USA (Arizona)",
          ],
          imitations: [
            ImitationItem(img: AppImages.peridotGlass, title: "Green Glass", desc: "Most common imitation; softer, less brilliance, and very inexpensive.\n",),
            ImitationItem(img: AppImages.peridotQuartz, title: "Dyed Quartz", desc: "Lower-quality quartz is dyed to mimic Peridot’s green color.\n",),
            ImitationItem(img: AppImages.peridotSynthetic, title: "Synthetic Olivine", desc: "Lab-grown material resembling Peridot but cheaper.",),
          ],
          history: [
            "Ancient Egyptians called Peridot the 'Gem of the Sun'.",
            "Believed to bring protection, harmony, and good health.",
            "Peridot is the birthstone for August.",
          ],
          care: [
            "Avoid heat: high temperature can cause cracks.",
            "Clean with mild soap and lukewarm water.",
            "Store separately—Peridot scratches easily..",
          ],
          uses: [
            "Jewelry: Rings, pendants, earrings.",
            "Healing: Believed to remove negative energy.",
            "Collectibles: Beautiful crystal clusters from Pakistan.",
          ],
          buyingTips: [
            "Check Color: Pure lime-green or vibrant green stones are most valuable.",
            "Examine Clarity: Eye-clean Peridot is preferred; avoid stones with black spots.",
            "Compare Prices: Check multiple reputable sellers to get a fair market price.",
            "Certification: Ask for certification to ensure authenticity and confirm no treatments.",
          ],
        ),
      }
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
