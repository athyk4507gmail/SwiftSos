import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your actual machine's IP address when testing on physical device
  static const String baseUrl = 'http://192.168.29.176:5000';

  // Send alert to backend
  static Future<bool> sendAlert({
    required String message,
    required String emergencyType,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/alerts/send');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'emergencyType': emergencyType,
          'location': 'Unknown', // Update to use actual location if needed
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error sending alert: $e');
      return false;
    }
  }

  // Get all alerts from backend
  static Future<List<dynamic>> getAlerts() async {
    try {
      final url = Uri.parse('$baseUrl/api/alerts/live');
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













