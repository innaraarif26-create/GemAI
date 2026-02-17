import 'package:flutter/material.dart';

class AppProductPriceText extends StatelessWidget
{
  const AppProductPriceText({
    super.key,
    this.currencySign = "Rs",
    required this.price,
    this.maxLines = 1,
  });

  final String currencySign, price;
  final int maxLines;


  @override
  Widget build(BuildContext context)
  {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
