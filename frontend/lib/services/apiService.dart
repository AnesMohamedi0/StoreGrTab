import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = 'https://localhost:7000/api'});

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP error! status: ${response.statusCode}');
    }
    return json.decode(response.body);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP error! status: ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}

final apiService = ApiService();