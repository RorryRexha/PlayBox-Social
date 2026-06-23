import 'api_service.dart';
import 'session_service.dart';

class AuthService {
  // =========================
  // 🔐 LOGIN
  // =========================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await ApiService.post(
        "login",
        body: {
          "email": email,
          "password": password,
        },
      );

      // Guardar token
      if (data["token"] != null) {
        await SessionService.saveToken(data["token"]);
      }

      return {
        "success": true,
        "data": data,
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // 📝 REGISTER
  // =========================
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final data = await ApiService.post(
        "register",
        body: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      if (data["token"] != null) {
        await SessionService.saveToken(data["token"]);
      }

      return {
        "success": true,
        "data": data,
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}