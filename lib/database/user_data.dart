import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _nameKey = 'user_name';

  static Future<void> saveUserData(String userEmail, String userPassword, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, userEmail);
    await prefs.setString(_passwordKey, userPassword);
    await prefs.setString(_nameKey, userName);
  }

  static Future<bool> validateUser(String userEmail, String userPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);
    return savedEmail == userEmail && savedPassword == userPassword;
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }
} 