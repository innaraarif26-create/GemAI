import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../../../../core/constants/sizes.dart';

class AppProductSafetyNotice extends StatelessWidget {
  const AppProductSafetyNotice({
    super.key,
  });


  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark ? Colors.grey[850] : Colors.grey[200], // subtle background
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text("Your Safety Matters to Us!", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600,),),
          const SizedBox(height: AppSizes.sm),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("•  "),
              Expanded(
                child: Text("Only meet in public / crowded places.", style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("•  "),
              Expanded(
                child: Text("Never go alone to meet a buyer / seller, always take someone with you.", style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("•  "),
              Expanded(
                child: Text("Check and inspect the product properly before purchasing it.", style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("•  "),
              Expanded(
                child: Text("Never pay anything in advance or transfer money before inspecting the product.", style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



