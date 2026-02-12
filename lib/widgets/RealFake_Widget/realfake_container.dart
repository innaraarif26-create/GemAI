import 'package:flutter/material.dart';
import '../../core/constants/image_strings.dart';
import '../../core/constants/sizes.dart';

class AppHomeRealFakeList extends StatelessWidget {
  const AppHomeRealFakeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 238, 238),
          borderRadius: BorderRadius.circular(AppSizes.sm),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 90,
              child: Image.asset(AppImages.malachite,fit: BoxFit.cover),
            ),
            Text("Real vs Fake", style: Theme.of(context).textTheme.bodySmall,),
            Text("Malachite", style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}

