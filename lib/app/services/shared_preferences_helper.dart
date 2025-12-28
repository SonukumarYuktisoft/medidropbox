// lib/services/shared_preferences_helper.dart
// Add these methods to your existing SharedPreferencesHelper class

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyUserToken = 'user_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserName = 'user_name';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyIsFirstTime = 'is_first_time';


 // First Time Setup
  static Future<void> setIsFirstTime(bool isFirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsFirstTime, isFirstTime);
  }

  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFirstTime) ?? true;
  }

  // Token Management
  static Future<void> setUserToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserToken, accessToken);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserToken);
  }

  static Future<void> clearUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserToken);
  }

  // User ID
  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // User Email
  static Future<void> setUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  // User Phone
  static Future<void> setUserPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserPhone, phone);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserPhone);
  }

  // User Name
  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Login Status
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Save User Data
  static Future<void> saveUserData({
    required String accessToken,
    required String userId,
    String? email,
    String? phone,
    String? name,
  }) async {
    await setUserToken(accessToken);
    await setUserId(userId);
    if (email != null) await setUserEmail(email);
    if (phone != null) await setUserPhone(phone);
    if (name != null) await setUserName(name);
    await setLoginStatus(true);
  }

  // Clear All User Data
  static Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserPhone);
    await prefs.remove(_keyUserName);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final accessToken = await getUserToken();
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    return accessToken != null && accessToken.isNotEmpty && isLoggedIn;
  }

  static Future<void> logoutAndResetApp() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // sab kuch clear
}

}