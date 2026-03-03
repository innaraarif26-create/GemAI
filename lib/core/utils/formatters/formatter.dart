import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._();

  /* -------------------- DATE & TIME -------------------- */
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // 14:30 → 02:30 PM
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  // 23 Jan 2026, 02:30 PM
  static String formatDateAndTime(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  /* -------------------- CURRENCY -------------------- */

  // 25000 → Rs. 25,000
  static String formatCurrency(num amount, {String symbol = 'Rs.'}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /* -------------------- PHONE NUMBER -------------------- */

  /// 03001234567 → 0300-1234567
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10)
     {
       return "(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,6)} ${phoneNumber.substring(6)}";
     }
    else if(phoneNumber.length == 11)
      {
        return "(${phoneNumber.substring(0,4)}) ${phoneNumber.substring(4,7)} ${phoneNumber.substring(7)}";
      }
    return phoneNumber;
  }
}
