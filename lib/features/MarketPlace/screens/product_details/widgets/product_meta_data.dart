import 'package:flutter/material.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import '../../../../../core/constants/sizes.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key, required this.product});

  final ProductModel product;

  Widget buildRow(String title, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.4),
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
        Text(
          "Product Details",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
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
              buildRow("Gem Type", product.gemType, context),
              divider(),
              buildRow("Color", product.color, context),
              divider(),
              buildRow("Origin", product.origin, context),
              divider(),
              buildRow("Weight(Carat)", product.weightCarat.toString(), context),
              divider(),
              buildRow("Cut", product.cut, context),
              divider(),
              buildRow("Clarity", product.clarity, context),
              divider(),
              buildRow("Treatment", product.treatment, context),
              divider(),
              buildRow("Certification", product.certification ? "Yes" : "No", context),
              divider(),
            ],
          ),
        ),
      ],
    );
  }
}