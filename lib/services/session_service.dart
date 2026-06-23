import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _tokenKey = "auth_token";

  // =========================
  // 💾 GUARDAR TOKEN
  // =========================
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // =========================
  // 📥 OBTENER TOKEN
  // =========================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // =========================
  // ❌ ELIMINAR TOKEN (LOGOUT)
  // =========================
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // =========================
  // 🔐 VERIFICAR SI HAY SESIÓN
  // =========================
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}