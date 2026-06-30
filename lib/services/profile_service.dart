import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'session_service.dart';

class ProfileService {
  // =========================
  // 👤 OBTENER PERFIL
  // =========================
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = await SessionService.getToken();

      final response = await http.get(
        Uri.parse("${ApiService.baseUrl}/profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      }

      throw Exception(data["message"] ?? "Error al obtener el perfil");
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }
}