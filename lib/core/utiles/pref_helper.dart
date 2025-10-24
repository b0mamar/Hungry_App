import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String userToken = 'user_token';
  static Future<void> saveUserToken(String token) async {
    // Save the user token to shared preferences or secure storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userToken, token);
  }

  static Future<String?> getUserToken() async {
    // Retrieve the user token from shared preferences or secure storage
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userToken);
  }

  static Future<void> clearUserToken() async {
    // Clear the user token from shared preferences or secure storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userToken);
  }
}
