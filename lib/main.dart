import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:GemAI/core/theme/app_theme.dart';
import 'package:GemAI/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'core/constants/colors.dart';
import 'data/repositories_authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Widgets Binding
   final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // GetX Local Storage
   await GetStorage.init();

  // Await Native Splash
   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Todo: Initialize Firebase

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  // Todo: Initialize Authentication

  runApp(const GemAi());
}

class GemAi extends StatelessWidget {
  const GemAi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Scaffold(
        backgroundColor: AppColors.accent,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
