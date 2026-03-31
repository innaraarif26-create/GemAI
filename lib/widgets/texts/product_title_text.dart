import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AppProductTitleText extends StatelessWidget
{
  const AppProductTitleText({super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context)
  {
    return Text(
      title,
      style: smallSize ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.buttonSecondary),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
