import 'dart:convert';
import 'package:flutter_app/config/app_config.dart';
import 'package:http/http.dart' as http;
class ApiService {

  static const String baseUrl = AppConfig.baseUrl; // Replace with your API base URL

  static Future<Map<String, dynamic>> getStudent(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/students/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load student');
    }
  }
}