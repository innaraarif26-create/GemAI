import 'package:flutter/material.dart';
import '../../../../../core/constants/sizes.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key});

  Widget buildRow(String title, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// Value
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() => const Divider(height: 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Text(
          "Product Details",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        /// Card Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Colors.black.withValues(alpha: 0.04),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              buildRow("Gem Type", "Natural Emerald", context),
              divider(),
              buildRow("Color", "Rich Green", context),
              divider(),
              buildRow("Origin", "Pakistan", context),
              divider(),
              buildRow("Weight(Carat)", "5.2 Carats", context),
              divider(),
              buildRow("Cut", "Oval Cut", context),
              divider(),
              buildRow("Clarity", "VVS", context),
              divider(),
              buildRow("Treatment", "Untreated", context),
              divider(),
              buildRow("Certification", "Yes", context),
              divider(),
            ],
          ),
        ),
      ],
    );
  }
}