import 'dart:developer' show log;
import 'package:medidropbox/app/services/secure_storage.dart';

class TokenManager {
  // Save tokens after login
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn, // in seconds
  }) async {
    try {
      // Calculate expiry time
      final expiryTime = DateTime.now()
          .add(Duration(seconds: expiresIn))
          .millisecondsSinceEpoch
          .toString();

      await SecureStorageService.saveAccessToken(accessToken);
      await SecureStorageService.saveRefreshToken(refreshToken);
      await SecureStorageService.saveTokenExpiry(expiryTime);

      log("✅ Tokens saved successfully");
      log("🔑 Access Token: ${accessToken.substring(0, 20)}...");
      log("⏰ Expires at: ${DateTime.fromMillisecondsSinceEpoch(int.parse(expiryTime))}");
    } catch (e) {
      log("❌ Error saving tokens: $e");
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    try {
      return await SecureStorageService.getAccessToken();
    } catch (e) {
      log("❌ Error getting access token: $e");
      return null;
    }
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    try {
      return await SecureStorageService.getRefreshToken();
    } catch (e) {
      log("❌ Error getting refresh token: $e");
      return null;
    }
  }

  // Check if token is expired
  static Future<bool> isTokenExpired() async {
    try {
      final expiryStr = await SecureStorageService.getTokenExpiry();

      if (expiryStr == null) {
        log("⚠️ No expiry time found");
        return true;
      }

      final expiryTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(expiryStr),
      );
      final now = DateTime.now();

      // Add 5 minute buffer before actual expiry
      final isExpired = now.isAfter(expiryTime.subtract(Duration(minutes: 5)));

      if (isExpired) {
        log("⏰ Token expired or expiring soon");
      }

      return isExpired;
    } catch (e) {
      log("❌ Error checking token expiry: $e");
      return true;
    }
  }

  // Update access token (after refresh)
  static Future<void> updateAccessToken(String newToken, int expiresIn) async {
    try {
      final expiryTime = DateTime.now()
          .add(Duration(seconds: expiresIn))
          .millisecondsSinceEpoch
          .toString();

      await SecureStorageService.saveAccessToken(newToken);
      await SecureStorageService.saveTokenExpiry(expiryTime);

      log("✅ Access token updated successfully");
    } catch (e) {
      log("❌ Error updating access token: $e");
    }
  }

  // Clear all tokens (logout)
  static Future<void> clearTokens() async {
    try {
      await SecureStorageService.delete('access_token');
      await SecureStorageService.delete('refresh_token');
      await SecureStorageService.delete('token_expiry');

      log("✅ Tokens cleared successfully");
    } catch (e) {
      log("❌ Error clearing tokens: $e");
    }
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    try {
      final accessToken = await getAccessToken();
      final isExpired = await isTokenExpired();

      return accessToken != null && !isExpired;
    } catch (e) {
      log("❌ Error checking authentication: $e");
      return false;
    }
  }

  // Get time until token expires
  static Future<Duration?> getTimeUntilExpiry() async {
    try {
      final expiryStr = await SecureStorageService.getTokenExpiry();

      if (expiryStr == null) return null;

      final expiryTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(expiryStr),
      );
      final now = DateTime.now();

      if (now.isAfter(expiryTime)) return Duration.zero;

      return expiryTime.difference(now);
    } catch (e) {
      log("❌ Error getting time until expiry: $e");
      return null;
    }
  }
}
