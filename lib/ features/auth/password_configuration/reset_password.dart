import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemai/%20features/auth/password_configuration/forgot_password_screen.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget
{
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.off(()=>ForgetPassword()),
             icon: const Icon(CupertinoIcons.clear),iconSize: 20,color: Color(0xFFB48B54),)
          ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
