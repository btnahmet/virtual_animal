import 'package:shared_preferences/shared_preferences.dart';

class ParentData {
  static const String _emailKey = 'parent_email';
  static const String _passwordKey = 'parent_password';
  static const String _nameKey = 'parent_name';

  static Future<void> saveParentData(String parentEmail, String parentPassword, String parentName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, parentEmail);
    await prefs.setString(_passwordKey, parentPassword);
    await prefs.setString(_nameKey, parentName);
  }

  static Future<bool> validateParent(String parentEmail, String parentPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);
    return savedEmail == parentEmail && savedPassword == parentPassword;
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }
} 