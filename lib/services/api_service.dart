import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.143:8000/api";

  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.get(url, headers: _headers(token: token));
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.post(
      url,
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.put(
      url,
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.delete(url, headers: _headers(token: token));
    return _processResponse(response);
  }

  // 🧠 CENTRAL DE MANEJO DE RESPUESTA
  static Map<String, dynamic> _processResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Error en la API');
    }
  }
}