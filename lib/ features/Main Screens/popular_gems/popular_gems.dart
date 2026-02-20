import 'package:flutter/material.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import '../../../core/constants/sizes.dart';
import '../../../models/gemstone_model.dart';

class GemsDetailScreen extends StatelessWidget
{
  const GemsDetailScreen({
    super.key,
    required this.gem
  });

  final GemDetailModel gem;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppAppBar(
        title: Text(gem.name,style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal:AppSizes.md, vertical: AppSizes.iconXs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              AppRoundedImage(width: double.infinity,height: 200, imageUrl: gem.image, applyImageRadius: false,fit: BoxFit.fill),
              const SizedBox(height: AppSizes.spaceBtwSections,),

              /// Price
              AppSectionHeading(title: "Price"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.prices.map((p)=> Text("• ${p.quality}: ${p.price}")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Quality Factors
              AppSectionHeading(title: "Quality Factors"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.qualityFactors.map((q)=> Text("• ${q.title}: ${q.description}")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Origin
              AppSectionHeading(title: "Main Origin"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.origins.map((o)=> Text("• $o")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Imitation
              AppSectionHeading(title: "Imitation"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.imitations.map((i)=> imitationItem(i)).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// History and Lore
              AppSectionHeading(title: "History & Lore"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.history.map((h)=> Text("• $h")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Care And Cleaning
              AppSectionHeading(title: "Care & Cleaning"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.care.map((c)=> Text("• $c")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Uses
              AppSectionHeading(title: "Uses"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.uses.map((u)=> Text("• $u")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Tips for Buying
              AppSectionHeading(title: "Tips for buying"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.buyingTips.map((b)=> Text("• $b")).toList(),
              const SizedBox(height: AppSizes.spaceBtwSections),

            ],
          ),
        ),
      ),
    );
  }
}
Widget imitationItem(ImitationItem item) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          item.img,
          width: 55,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              fontFamily: 'TimesRomanFont',
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "${item.title} ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: item.desc),
            ],
          ),
        ),
      ),
    ],
  );
}

