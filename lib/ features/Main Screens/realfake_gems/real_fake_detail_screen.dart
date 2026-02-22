import 'package:flutter/material.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import '../../../core/constants/sizes.dart';
import '../../../models/real_fake_gem_model.dart';

class RealFakeDetailScreen extends StatelessWidget {
  const RealFakeDetailScreen({
    super.key,
    required this.gem,
  });

  final RealFakeGem gem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RichText(
                text: TextSpan( style: Theme.of(context).textTheme.headlineMedium,
                children: const [
                  TextSpan(text: "Real  "),
                  TextSpan(text: "V", style: TextStyle(color: Colors.orange)),
                  TextSpan(text: "S", style: TextStyle(color: Colors.red)),
                  TextSpan(text: "  Fake"),
                 ],
                ),
              ),
              const SizedBox(height: AppSizes.xs),


              /// NAME
              Text(gem.name,style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: AppSizes.xs),

              const SizedBox(height: AppSizes.xs),
              /// IMAGE
              AppRoundedImage(width: double.infinity, height: 140, imageUrl: gem.image,),
              const SizedBox(height: AppSizes.xs),

              /// DESCRIPTION
              Text(gem.description),
              const SizedBox(height: AppSizes.md),

              /// SECTIONS
              buildSection(context, "Overview", gem.overviewReal, gem.overviewFake),
              buildSection(context, "Color", gem.colorReal, gem.colorFake),
              buildSection(context, "Touch Test", gem.touchReal, gem.touchFake),
              buildSection(context, "Specific Gravity", gem.gravityReal, gem.gravityFake),
              buildSection(context, "Acid Test", gem.acidReal, gem.acidFake),
              const SizedBox(height: AppSizes.md),
            ],
          ),
        ),
      ),
    );
  }

  /// SECTION WITH HEADING + EQUAL HEIGHT BOXES
  Widget buildSection(BuildContext context, String title, String real, String fake) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeading(title: title),
        const SizedBox(height: AppSizes.spaceBtwItems),

        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: infoBox(context, "Real", real, Colors.orange.shade50, isLeft: true,),),
              Expanded(child: infoBox(context, "Fake", fake, Colors.red.shade50, isRight: true,),),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),
      ],
    );
  }

  /// REAL & FAKE BOX WITH OUTER RADIUS
  Widget infoBox(
      BuildContext context,
      String label,
      String text,
      Color color, {
        bool isLeft = false,
        bool isRight = false,
      }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: isLeft ? const Radius.circular(12) : Radius.zero,
          bottomLeft: isLeft ? const Radius.circular(12) : Radius.zero,
          topRight: isRight ? const Radius.circular(12) : Radius.zero,
          bottomRight: isRight ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: AppSizes.sm),
          Text(text),
        ],
      ),
    );
  }
}