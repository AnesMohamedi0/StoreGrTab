import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/environment.dart';

class ApiClient {
  final http.Client _client;
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Uri _uri(String path, [Map<String, dynamic>? query]) => Uri.parse(Environment.apiBaseUrl).replace(
        path: path,
        queryParameters: query?.map((k, v) => MapEntry(k, v.toString())),
      );

  Future<http.Response> get(String path, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    final uri = _uri(path, query);
    final res = await _client.get(uri, headers: {
      'Content-Type': 'application/json',
      ...?headers,
    });
    _throwOnError(res);
    return res;
  }

  Future<http.Response> post(String path, {Object? body, Map<String, String>? headers}) async {
    final uri = _uri(path);
    final res = await _client.post(uri, headers: {
      'Content-Type': 'application/json',
      ...?headers,
    }, body: body is String ? body : jsonEncode(body));
    _throwOnError(res);
    return res;
  }

  void _throwOnError(http.Response res) {
    if (res.statusCode >= 400) {
      throw HttpException('HTTP ${res.statusCode}: ${res.body}');
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}
