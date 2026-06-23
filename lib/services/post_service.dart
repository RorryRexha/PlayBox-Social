import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'session_service.dart';

class PostService {

  // =========================
  // 📤 CREAR POST (SIN IMAGEN)
  // =========================
  static Future<Map<String, dynamic>> createPost({
    required String description,
    String? gameId,
  }) async {
    try {
      final token = await SessionService.getToken();

      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}/posts"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "description": description,
          "game_id": gameId,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          "success": true,
          "data": data,
        };
      }

      return {
        "success": false,
        "message": data["message"] ?? "Error al crear post",
      };
    } catch (e) {
      return {
        "success": false,
        "message": "Error de conexión: $e",
      };
    }
  }

  // =========================
  // 📸 SUBIR MEDIA (IMAGEN)
  // =========================
  static Future<Map<String, dynamic>> uploadMedia({
    required int postId,
    required File file,
  }) async {
    try {
      final token = await SessionService.getToken();

      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiService.baseUrl}/media"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      request.fields["post_id"] = postId.toString();
      request.fields["type"] = "image";

      request.files.add(
        await http.MultipartFile.fromPath("file", file.path),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": data};
      }

      return {
        "success": false,
        "message": data["message"] ?? "Error al subir media",
      };
    } catch (e) {
      return {
        "success": false,
        "message": "Error de conexión: $e",
      };
    }
  }

  // =========================
  // 📥 OBTENER POSTS
  // =========================
  static Future<List<dynamic>> getPosts() async {
    try {
      final token = await SessionService.getToken();

      final response = await http.get(
        Uri.parse("${ApiService.baseUrl}/posts"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      }

      throw Exception("Error al cargar posts");
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }
}