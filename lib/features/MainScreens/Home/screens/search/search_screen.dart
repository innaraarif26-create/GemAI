import 'package:flutter/material.dart';
import 'package:gemai/features/MainScreens/Home/models/search_result_model.dart';
import 'package:gemai/features/MainScreens/Home/screens/Articles/article_pdf_viewer.dart';
import 'package:gemai/features/MainScreens/Home/screens/popular_gems/popular_gems_detail_screen.dart';
import 'package:gemai/features/MainScreens/Home/screens/realfake_gems/real_fake_detail_screen.dart';
import 'package:gemai/features/MainScreens/Home/models/popular_gemstone_model.dart';
import 'package:gemai/features/MainScreens/Home/models/real_fake_gem_model.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GemSearchController());
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: dark ? AppColors.white : AppColors.dark,
                  size: 20,
                ),
              ),
              Expanded(
                child: Obx(() => TextField(
                  controller: controller.textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search gemstones, books, articles...',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: InputBorder.none,
                    suffixIcon: controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: controller.clearSearch,
                          )
                        : null,
                  ),
                  onChanged: controller.onSearchChanged,
                )),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.xs,
            ),
            child: Row(
              children: controller.categories.map((category) {
                final isSelected = controller.selectedCategory.value == category;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSizes.sm),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) => controller.setCategory(category),
                    selectedColor: AppColors.accent,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.white : null,
                      fontSize: AppSizes.fontSizeSm,
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
        ),
      ),
      body: Obx(() {
        final query = controller.searchQuery.value;
        final category = controller.selectedCategory.value;
        final results = controller.searchResults;

        if (query.isEmpty && category == 'All') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.search_normal,
                  size: 64,
                  color: dark ? AppColors.darkerGrey : AppColors.grey,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  'Search for gemstones, books,\narticles and more',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ? AppColors.darkerGrey : AppColors.darkGrey,
                      ),
                ),
              ],
            ),
          );
        }

        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.search_status,
                  size: 64,
                  color: dark ? AppColors.darkerGrey : AppColors.grey,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  query.isNotEmpty
                      ? 'No results found for "$query"'
                      : 'No items in this category',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ? AppColors.darkerGrey : AppColors.darkGrey,
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSizes.md),
          itemCount: results.length,
          itemBuilder: (_, index) {
            final result = results[index];
            return _SearchResultTile(result: result, dark: dark);
          },
        );
      }),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.result, required this.dark});

  final SearchResult result;
  final bool dark;

  void _onTap() {
    if (result.category == 'Gems' && result.data is GemDetailModel) {
      Get.to(() => GemsDetailScreen(gem: result.data as GemDetailModel));
    } else if (result.category == 'Articles' && result.data is Map) {
      final article = result.data as Map<String, String>;
      Get.to(() => ArticlePDFViewer(
            title: article['title']!,
            pdfPath: article['pdf']!,
          ));
    } else if (result.category == 'Real/Fake' && result.data is RealFakeGem) {
      Get.to(() => RealFakeDetailScreen(gem: result.data as RealFakeGem));
    }
    // Books have no detail screen yet
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        decoration: BoxDecoration(
          color: dark ? AppColors.dark : AppColors.lightContainer,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
          border: Border.all(
            color: dark ? AppColors.darkerGrey : AppColors.grey,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppSizes.cardRadiusMd),
              ),
              child: SizedBox(
                width: 80,
                height: 80,
                child: result.isNetworkImage
                    ? Image.network(
                        result.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                        ),
                      )
                    : Image.asset(
                        result.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSizes.cardRadiusXs),
                    ),
                    child: Text(
                      result.category,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.accent,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            if (result.category != 'Books')
              Icon(
                Icons.arrow_forward_ios,
                size: AppSizes.iconSm,
                color: dark ? AppColors.darkerGrey : AppColors.darkGrey,
              ),
            const SizedBox(width: AppSizes.sm),
          ],
        ),
      ),
    );
  }
}
