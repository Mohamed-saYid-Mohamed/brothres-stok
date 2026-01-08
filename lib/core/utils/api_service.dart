import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android Emulator, your local IP for real devices
  static const String baseUrl = 'http://10.0.2.2/brothers_stock/api';

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      return _processResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> delete(String endpoint, {int? id}) async {
    try {
      final url = id != null
          ? '$baseUrl/$endpoint?id=$id'
          : '$baseUrl/$endpoint';
      final response = await http.delete(Uri.parse(url));
      return _processResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return {'status': 'error', 'message': 'Invalid JSON response'};
      }
    } else {
      return {
        'status': 'error',
        'message': 'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      };
    }
  }
}
