import 'package:flutter/material.dart';
import 'package:gemai/core/utils/validators/validation.dart';
import 'package:gemai/features/auth/controllers/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text.dart';
import '../../password_configuration/forgot_password_screen.dart';

class AppLoginForm extends StatelessWidget
{
   const AppLoginForm({super.key});

   @override
   Widget build(BuildContext context)
   {
     final controller = Get.put(LoginController());

     return  Form(
       key: controller.loginFormKey,
         child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 30,),
             child: Column(
               children: [
               /// Email
               TextFormField(
                 controller: controller.email,
               validator: (value) => AppValidator.validateEmail(value),
               decoration: const InputDecoration(
                 prefixIcon: Icon(Iconsax.direct_right,size: 20,), labelText: AppTexts.email,
               ),
             ),
             const SizedBox(height: AppSizes.spaceBtwInputFields),

                 /// Password
                 Obx(
                       () => TextFormField(
                     controller: controller.password,
                     validator: (value) => AppValidator.validateEmptyText("Password",value),
                     obscureText: controller.hidePassword.value,
                     decoration: InputDecoration(
                       labelText: AppTexts.password,
                       prefixIcon:
                       const Icon(Iconsax.password_check, size: 20),
                       suffixIcon: IconButton(
                         onPressed: () => controller.hidePassword.value =
                         !controller.hidePassword.value,
                         icon: Icon(
                           controller.hidePassword.value
                               ? Iconsax.eye_slash
                               : Iconsax.eye,
                         ),
                       ),
                     ),
                   ),
                 ),

             const SizedBox(
               height: AppSizes.spaceBtwInputFields / 2,
             ),

             /// Remember Me & Forget Password
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Obx(
                       ()=>  Checkbox(
                         value: controller.rememberMe.value,
                         onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value,),
                     ),

                     const Text(AppTexts.rememberMe),
                   ],
                 ),

                 /// Forget Password
                 TextButton(
                   onPressed: ()
                   {
                     Get.off(() => const ForgetPassword());
                   },
                   child:const Text(AppTexts.forgetPassword,style: TextStyle(color: Color.fromARGB(255, 180, 139, 84),fontSize: 13, fontFamily: 'TimesRomanFont'),),
                 ),
               ],
             ),
             const SizedBox(height: AppSizes.defaultSpace),

             /// Sign In Button
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () => controller.emailAndPasswordSignIn() ,
                 child: const Text(AppTexts.signIn),
               ),
             ),
             ]
         ),
       ),
     );
   }
 }
