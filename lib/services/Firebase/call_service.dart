import 'package:url_launcher/url_launcher.dart';

class CallService {
  static Future<void> callPhoneNumber(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);

    if (!await canLaunchUrl(uri)) {
      throw Exception('Could not launch dialer for $phone');
    }

    await launchUrl(uri);
  }
}