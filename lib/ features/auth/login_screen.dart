import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';

class LoginScreen extends StatelessWidget
{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
           padding: EdgeInsets.only(
             top: AppSizes.appBarHeight,
             bottom: AppSizes.defaultSpace,
             left: AppSizes.defaultSpace,
             right: AppSizes.defaultSpace,
           )
        )
      ),
    );
  }
}
