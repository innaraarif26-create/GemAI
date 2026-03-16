import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class AppFavoriteCounterIcon extends StatelessWidget {
  const AppFavoriteCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
    this.count = 0,
  });

  final VoidCallback onPressed;
  final Color iconColor;
  final int count;

  @override
  Widget build(BuildContext context) {
    final hasItems = count > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.favorite_border, color: iconColor),
        ),

        if (hasItems)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: AppColors.white, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
      ],
    );
  }
}