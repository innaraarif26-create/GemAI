import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/controllers/product_controller.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_card_vertical.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
      appBar: const AppAppBar(
        title: Text("Popular Products"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                final selected =
                _dropdownValueFromController(controller.sortBy.value, controller.descending.value);

                return DropdownButtonFormField<String>(
                  initialValue: selected,
                  hint: Text("Sort by", style: Theme.of(context).textTheme.bodySmall),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort, color: Colors.grey)),
                  onChanged: (value) {
                    if (value == null) return;

                    if (value == "Name") {
                      controller.sortBy.value = "createdAt";
                      controller.descending.value = true;
                      return;
                    }

                    if (value == "Higher Price") {
                      controller.sortBy.value = "price";
                      controller.descending.value = true;
                    } else if (value == "Lower Price") {
                      controller.sortBy.value = "price";
                      controller.descending.value = false;
                    } else if (value == "Newest") {
                      controller.sortBy.value = "createdAt";
                      controller.descending.value = true;
                    } else if (value == "Popularity") {
                      controller.sortBy.value = "views";
                      controller.descending.value = true;
                    }
                  },
                  items: ["Name", "Higher Price", "Lower Price", "Newest", "Popularity"]
                      .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                      .toList(),
                );
              }),

              const SizedBox(height: AppSizes.spaceBtwSections),

              Obx(() {
                return StreamBuilder(
                  stream: controller.allStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) return Text("Error: ${snapshot.error}");

                    final items = snapshot.data ?? [];
                    return AppGridLayout(
                      itemCount: items.length,
                      itemBuilder: (_, index) => AppProductCardVertical(product: items[index]),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String _dropdownValueFromController(String sortBy, bool descending) {
    if (sortBy == "createdAt" && descending == true) return "Newest";
    if (sortBy == "views" && descending == true) return "Popularity";
    if (sortBy == "price" && descending == true) return "Higher Price";
    if (sortBy == "price" && descending == false) return "Lower Price";
    return "Newest";
  }
}