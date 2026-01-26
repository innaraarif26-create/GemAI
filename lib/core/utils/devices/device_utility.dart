import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceUtilities {
  DeviceUtilities._();

  /* -------------------- PLATFORM -------------------- */

  static bool isAndroid() => Platform.isAndroid;

  static bool isIOS() => Platform.isIOS;

  static bool isPhysicalDevice() => Platform.isAndroid || Platform.isIOS;

  /* -------------------- SCREEN -------------------- */

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery .of(context).size.height;

  static double getPixelRatio(BuildContext context) =>
      MediaQuery .of(context).devicePixelRatio;

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding .top;

  static double getBottomNavigationBarHeight()
  {
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight()
  {
    return kToolbarHeight;
  }

  /* -------------------- ORIENTATION -------------------- */

  static bool isLandscapeOrientation(BuildContext context) =>
      MediaQuery .of(context) .orientation == Orientation.landscape;

  static bool isPortraitOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  /// Disable landscape mode (Portrait only)
  static Future<void> setPortraitOnly() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  /// Enable all orientations again
  static Future<void> enableAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  /* -------------------- KEYBOARD -------------------- */

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isKeyboardAvailable(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  static double getKeyboardHeight(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;

  /* -------------------- SYSTEM UI -------------------- */

  static void setStatusBarColor(Color color,
      {Brightness iconBrightness = Brightness.light}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness,
      ),
    );
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  static void setFullScreen() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }

  /* -------------------- INTERNET -------------------- */

  static Future<bool> hasInternetConnection() async
  {
  try {
  final result = await InternetAddress.lookup('exmape.com');
  return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch(_)
  {
  return false;
  }
}

  /* -------------------- URL LAUNCHER -------------------- */

  static Future<void> launchUrlExternal(String url) async {
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri))
    {
      throw 'Could not launch $url';
    }
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
