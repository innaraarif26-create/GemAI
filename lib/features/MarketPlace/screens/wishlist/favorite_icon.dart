import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/popups/login_required_dialog.dart';

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

  Future<void> _handlePressed() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await showLoginRequiredDialog(
        message: "Please login to view your wishlist.",
      );
      return;
    }

    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: _handlePressed,
          icon: Icon(Icons.favorite_border, color: iconColor),
        ),
        if (count > 0)
          Positioned(
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.black,
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