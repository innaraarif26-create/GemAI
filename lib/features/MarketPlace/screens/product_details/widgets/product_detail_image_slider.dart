import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../widgets/appbar/appbar.dart';
import '../../../../../widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../widgets/indicators/dot_indicators.dart';

class AppProductImageSlider extends StatefulWidget {
  const AppProductImageSlider({
    super.key,
    required this.imageUrls,
    this.isFav = false,
    this.onHeartPressed,
  });

  final List<String> imageUrls;
  final bool isFav;
  final VoidCallback? onHeartPressed;

  @override
  State<AppProductImageSlider> createState() => _AppProductImageSliderState();
}

class _AppProductImageSliderState extends State<AppProductImageSlider> {
  late final PageController _pageController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(covariant AppProductImageSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_index >= widget.imageUrls.length) {
      _index = 0;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final hasImages = widget.imageUrls.isNotEmpty;

    return AppCurvedEdgeWidget(
      child: Container(
        width: double.infinity,
        color: dark ? AppColors.darkerGrey : AppColors.light,
        child: Stack(
          children: [
            /// MAIN SLIDER (swipe)
            SizedBox(
              height: 400,
              width: double.infinity,
              child: hasImages
                  ? PageView.builder(
                controller: _pageController,
                itemCount: widget.imageUrls.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final url = widget.imageUrls[i];
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Iconsax.image, size: 70)),
                  );
                },
              )
                  : const Center(child: Icon(Iconsax.image, size: 70)),
            ),

            /// Gradient overlay for readability
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.30),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.30),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            /// INDICATORS (dots) instead of thumbnails
            if (hasImages && widget.imageUrls.length > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: 16,
                child: Center(
                  child: DotsIndicator(
                    count: widget.imageUrls.length,
                    index: _index,
                    activeColor: AppColors.accent,
                    inactiveColor: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ),
            AppAppBar(
              showBackArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}
