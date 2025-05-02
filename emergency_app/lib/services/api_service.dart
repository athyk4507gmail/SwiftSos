import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 127.0.0.1 instead of localhost for Flutter Web to resolve correctly
  static const String baseUrl = 'http://127.0.0.1:5000/api';

  static Future<bool> sendAlert({
    required String message,
    required String emergencyType,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/alerts/send');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'emergencyType': emergencyType,
          'location': 'Unknown',
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error sending alert: $e');
      return false;
    }
  }

  static Future<List<dynamic>> getAlerts() async {
    try {
      final url = Uri.parse('$baseUrl/alerts/live');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load alerts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching alerts: $e');
      return [];
    }
  }
}















