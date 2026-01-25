import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelperFunctions {
  AppHelperFunctions._();

  /* -------------------- GET COLOR -------------------- */
  static Color getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.black; // default color
    }
  }

  /* -------------------- SNACK BAR -------------------- */
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /* -------------------- ALERT DIALOG -------------------- */
  static Future<void> showAlert(
      BuildContext context, {
        String title = 'Alert',
        String content = '',
        String okText = 'OK',
      }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(okText),
          )
        ],
      ),
    );
  }

  /* -------------------- NAVIGATION -------------------- */
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /* -------------------- TRUNCATE TEXT -------------------- */
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /* -------------------- DARK MODE CHECK -------------------- */
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /* -------------------- SCREEN SIZE -------------------- */
  static Size screenSize()
  {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenWidth()
  {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double screenHeight()
  {
    return MediaQuery.of(Get.context!).size.height;
  }

  /* -------------------- WRAP WIDGET -------------------- */
  static Widget wrapWidget(Widget child,
      {EdgeInsetsGeometry padding = const EdgeInsets.all(8),
        Color? color,
        BoxDecoration? decoration}) {
    return Container(
      padding: padding,
      color: color,
      decoration: decoration,
      child: child,
    );
  }

  /* -------------------- REMOVE DUPLICATES -------------------- */
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
