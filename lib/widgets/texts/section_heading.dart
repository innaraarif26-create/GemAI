import 'package:flutter/material.dart';

class AppSectionHeading extends StatelessWidget
{
  const AppSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle = "View all",
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: Theme.of(context).textTheme.titleSmall!.apply(color: textColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
        Spacer(),
        if (showActionButton)  TextButton(onPressed: onPressed , child: Text(buttonTitle))
      ],
    );
  }
}
