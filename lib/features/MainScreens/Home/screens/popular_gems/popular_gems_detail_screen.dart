import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:gemai/widgets/texts/section_heading.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../models/popular_gemstone_model.dart';

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
        title: Text(gem.name,style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal:AppSizes.md, vertical: AppSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              AppRoundedImage(width: double.infinity,height: 200, imageUrl: gem.detailImage, applyImageRadius: false,fit: BoxFit.fill,isNetworkImage: true),
              const SizedBox(height: AppSizes.md,),

              /// Price
              AppSectionHeading(title: "Price"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.prices.map((p)=> Text("• ${p.quality}: ${p.price}")),
              const SizedBox(height: AppSizes.md),

              /// Quality Factors
              AppSectionHeading(title: "Quality Factors"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.qualityFactors.map((q)=> Text("• ${q.title}: ${q.description}"),),
              const SizedBox(height: AppSizes.md),

              /// Origin
              AppSectionHeading(title: "Main Origin"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.origins.map((o)=> Text("• $o")),
              const SizedBox(height: AppSizes.md),

              /// Imitation
              AppSectionHeading(title: "Imitation"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.imitations.map((i)=> imitationItem(context,i)),
              const SizedBox(height: AppSizes.md),

              /// History and Lore
              AppSectionHeading(title: "History & Lore"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.history.map((h)=> Text("• $h")),
              const SizedBox(height: AppSizes.md),

              /// Care And Cleaning
              AppSectionHeading(title: "Care & Cleaning"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.care.map((c)=> Text("• $c")),
              const SizedBox(height: AppSizes.md),

              /// Uses
              AppSectionHeading(title: "Uses"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.uses.map((u)=> Text("• $u")),
              const SizedBox(height: AppSizes.md),

              /// Tips for Buying
              AppSectionHeading(title: "Tips for buying"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ...gem.buyingTips.map((b)=> Text("• $b")),
              const SizedBox(height: AppSizes.md),

            ],
          ),
        ),
      ),
    );
  }
}
Widget imitationItem(BuildContext context,ImitationItem item)
{
  final bool dark =  AppHelperFunctions.isDarkMode(context);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(item.img, width: 55, height: 50, fit: BoxFit.cover,errorBuilder: (_,__,___)=> const Icon(Icons.error)),
      ),
      const SizedBox(width: AppSizes.md),
      Expanded(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              fontFamily: 'TimesRomanFont',
              color: dark ? Colors.white : Colors.black,
            ),
            children: [
              TextSpan(
                text: "${item.title}: ",
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

