import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<String> checkBackend() async {
    final response = await http.get(
      Uri.parse('$baseUrl/'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Backend error: ${response.statusCode}',
      );
    }
  }

  static Future<List<dynamic>> getCrops() async {
    final response = await http.get(
      Uri.parse('$baseUrl/crops'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load crops: ${response.statusCode}',
      );
    }
  }
}