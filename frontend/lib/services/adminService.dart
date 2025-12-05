import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminService {
  final String baseUrl;

  AdminService({this.baseUrl = 'http://localhost:5043/api'});

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Email': email, 'Password': password}),
    );

    if (response.statusCode == 200) {
      // Handle successful login
      return true;
    } else {
      // Handle login error
      return false;
    }
  }
}
