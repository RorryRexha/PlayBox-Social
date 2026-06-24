import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'session_service.dart';

class PostService {

  // =========================
  // 📤 CREAR POST
  // =========================
  static Future<Map<String, dynamic>> createPost({
    required String description,
    String? gameId,
    File? image,
  }) async {
    try {
      final token = await SessionService.getToken();

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiService.baseUrl}/posts"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      request.fields["description"] = description;

      if (gameId != null) {
        request.fields["game_id"] = gameId;
      }

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath("image", image.path),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": data};
      }

      return {
        "success": false,
        "message": data["message"] ?? "Error al crear post",
      };
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
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

  // =========================
  // ❤️ LIKE POST
  // =========================
  static Future<Map<String, dynamic>> likePost(int postId) async {
    try {
      final token = await SessionService.getToken();

      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}/posts/$postId/like"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": data};
      }

      return {
        "success": false,
        "message": data["message"] ?? "Error al dar like",
      };
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }

  // =========================
  // 💔 UNLIKE POST
  // =========================
  static Future<Map<String, dynamic>> unlikePost(int postId) async {
    try {
      final token = await SessionService.getToken();

      final response = await http.delete(
        Uri.parse("${ApiService.baseUrl}/posts/$postId/like"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": data};
      }

      return {
        "success": false,
        "message": data["message"] ?? "Error al quitar like",
      };
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }
}