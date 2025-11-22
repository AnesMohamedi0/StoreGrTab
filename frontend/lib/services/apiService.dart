import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = 'http://localhost:5043/api'});

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

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP error! status: ${response.statusCode}');
    }
    // PUT might return empty body
    return response.body.isEmpty ? null : json.decode(response.body);
  }

  Future<void> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.delete(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP error! status: ${response.statusCode}');
    }
  }

  Future<dynamic> getCommunesByProvinceId(int provinceId) async {
    final uri = Uri.parse('$baseUrl/Commune/Province/$provinceId');
    final response = await http.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP error! status: ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}

final apiService = ApiService();
