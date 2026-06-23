import 'api_service.dart';
import 'session_service.dart';

class UserService {
  // =========================
  // 👤 OBTENER USUARIO LOGUEADO
  // =========================
  static Future<Map<String, dynamic>?> getUser() async {
    try {
      final token = await SessionService.getToken();

      final data = await ApiService.get(
        "user",
        token: token,
      );

      return data;
    } catch (e) {
      throw Exception("Error al obtener usuario: $e");
    }
  }
}