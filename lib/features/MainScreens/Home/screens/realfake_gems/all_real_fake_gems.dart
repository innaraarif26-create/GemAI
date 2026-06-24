import 'package:flutter/material.dart';
import 'package:gemai/widgets/layouts/grid_layout.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../widgets/appbar/appbar.dart';
import '../../../../../widgets/data/real_fake_gems_data.dart';
import '../../../../../widgets/image_widget/rounded_image.dart';
import 'real_fake_detail_screen.dart';

class AllRealFakeGemsScreen extends StatefulWidget {
  const AllRealFakeGemsScreen({super.key});

  @override
  State<AllRealFakeGemsScreen> createState() => _AllRealFakeGemsScreenState();
}

class _AllRealFakeGemsScreenState extends State<AllRealFakeGemsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: const Text("All Real vs Fake Gems"),
        showBackArrow: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: AppGridLayout(
              itemCount: realFakeGems.length,
              crossAxisCount: 2,
              mainAxisExtent: 240,
              itemBuilder: (_, index) {
                final gem = realFakeGems[index];
                return _GemCard(gem: gem, index: index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated card widget for each gem entry.
class _GemCard extends StatefulWidget {
  const _GemCard({required this.gem, required this.index});

  final Map<String, dynamic> gem;
  final int index;

  @override
  State<_GemCard> createState() => _GemCardState();
}

class _GemCardState extends State<_GemCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  // Gem-themed gradient pairs for light and dark modes.
  static const List<List<Color>> _lightGradients = [
    [Color(0xFFE8D5FF), Color(0xFFF3EBFF)],
    [Color(0xFFD5EEFF), Color(0xFFEBF5FF)],
    [Color(0xFFFFE5D5), Color(0xFFFFF3EB)],
    [Color(0xFFD5FFE8), Color(0xFFEBFFF3)],
    [Color(0xFFFFD5E8), Color(0xFFFFEBF3)],
    [Color(0xFFFFF3D5), Color(0xFFFFFAEB)],
  ];

  static const List<List<Color>> _darkGradients = [
    [Color(0xFF2D1F3D), Color(0xFF1E1530)],
    [Color(0xFF1F2D3D), Color(0xFF151E30)],
    [Color(0xFF3D2D1F), Color(0xFF301E15)],
    [Color(0xFF1F3D2D), Color(0xFF153020)],
    [Color(0xFF3D1F2D), Color(0xFF301520)],
    [Color(0xFF3D3520), Color(0xFF302A15)],
  ];

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _scaleController.forward();
  void _onTapUp(TapUpDetails _) => _scaleController.reverse();
  void _onTapCancel() => _scaleController.reverse();

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final gradients = dark ? _darkGradients : _lightGradients;
    final gradient = gradients[widget.index % gradients.length];

    return GestureDetector(
      onTap: () => Get.to(() => RealFakeDetailScreen(gem: widget.gem["model"])),
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            border: Border.all(
              color: dark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.9),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: dark
                    ? Colors.black.withValues(alpha: 0.45)
                    : Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                spreadRadius: 0,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: dark
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.8),
                blurRadius: 4,
                spreadRadius: -1,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// IMAGE
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.sm,
                    AppSizes.sm,
                    AppSizes.sm,
                    AppSizes.xs,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                    child: AppRoundedImage(
                      imageUrl: widget.gem["image"],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              /// TITLE SECTION
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.sm,
                  AppSizes.xs,
                  AppSizes.sm,
                  AppSizes.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFD62828)],
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.compare_arrows_rounded,
                            color: Colors.white,
                            size: AppSizes.iconXs,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "Real vs Fake",
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.xs),

                    /// Gem name
                    Text(
                      widget.gem["title"],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: dark ? Colors.white : Colors.black87,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}