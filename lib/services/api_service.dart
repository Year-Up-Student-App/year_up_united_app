import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'http://localhost:8080/api'; // Replace with your API base URL

  static Future<void> deleteData(String endpoint, String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data at $endpoint/$id');
    }
  }
}