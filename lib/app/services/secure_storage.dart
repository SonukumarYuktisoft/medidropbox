

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' show log;

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  // Write operations
  static Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      log("✅ SecureStorage: Saved $key");
    } catch (e) {
      log("❌ SecureStorage Write Error: $e");
    }
  }

  // Read operations
  static Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value;
    } catch (e) {
      log("❌ SecureStorage Read Error: $e");
      return null;
    }
  }

  // Delete operations
  static Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      log("✅ SecureStorage: Deleted $key");
    } catch (e) {
      log("❌ SecureStorage Delete Error: $e");
    }
  }

  // Clear all
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      log("✅ SecureStorage: Cleared all data");
    } catch (e) {
      log("❌ SecureStorage Clear Error: $e");
    }
  }

  // Token operations
  static Future<void> saveAccessToken(String token) =>
      write(_accessTokenKey, token);

  static Future<void> saveRefreshToken(String token) =>
      write(_refreshTokenKey, token);

  static Future<void> saveTokenExpiry(String expiry) =>
      write(_tokenExpiryKey, expiry);

  static Future<String?> getAccessToken() => read(_accessTokenKey);

  static Future<String?> getRefreshToken() => read(_refreshTokenKey);

  static Future<String?> getTokenExpiry() => read(_tokenExpiryKey);

  // User data operations
  static Future<void> saveUserId(String userId) => write(_userIdKey, userId);

  static Future<void> saveUserEmail(String email) =>
      write(_userEmailKey, email);

  static Future<String?> getUserId() => read(_userIdKey);

  static Future<String?> getUserEmail() => read(_userEmailKey);

  // Check if data exists
  static Future<bool> containsKey(String key) async {
    final value = await read(key);
    return value != null;
  }

  // Get all keys
  static Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      log("❌ SecureStorage ReadAll Error: $e");
      return {};
    }
  }
}