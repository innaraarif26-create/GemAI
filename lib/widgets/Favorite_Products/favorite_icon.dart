import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AppFavoriteCounterIcon extends StatelessWidget {
  const AppFavoriteCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon:  Icon(Icons.favorite_border,color: iconColor,),),
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
              child: Text("2",style: Theme.of(context).textTheme.labelLarge!.apply(color: AppColors.white,fontSizeFactor: 0.8)),
            ),
          ),
        ),
      ],
    );
  }
}
