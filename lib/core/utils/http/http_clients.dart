import 'dart:convert';
import 'package:http/http.dart' as http;

class AppHttpHelper {
  AppHttpHelper._();

  static const String _baseUrl = 'http://your_api_base_url.com';

  /* -------------------- GET REQUEST -------------------- */

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
    );
    return _handleResponse(response);
  }

  /* -------------------- POST REQUEST -------------------- */

  static Future<Map<String, dynamic>> post(
      String endpoint,
      dynamic data,
      ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /* -------------------- PUT REQUEST -------------------- */

  static Future<Map<String, dynamic>> put(
      String endpoint,
      dynamic data,
      ) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /* -------------------- DELETE REQUEST -------------------- */

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
    );
    return _handleResponse(response);
  }

  /* -------------------- HTTP RESPONSE HANDLER -------------------- */

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      // Success response
      if (response.body.isNotEmpty) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {};
      }
    } else {
      // Error response
      throw Exception(
        'HTTP Error: $statusCode | ${response.reasonPhrase}',
      );
    }
  }
}
