import 'dart:developer' show log;
import 'package:dio/dio.dart';
import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/app/services/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final String refreshTokenEndpoint;
  final Function()? onTokenRefreshFailed;

  AuthInterceptor(
    this._dio, {
    required this.refreshTokenEndpoint,
    this.onTokenRefreshFailed,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for refresh token endpoint
    if (options.path.contains(refreshTokenEndpoint)) {
      return handler.next(options);
    }

    // Check if token is expired
    final isExpired = await TokenManager.isTokenExpired();

    if (isExpired) {
      log("🔄 Token expired, refreshing...");
      final refreshed = await _refreshToken();

      if (!refreshed) {
        log("❌ Token refresh failed");
        await _handleLogout();
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Token refresh failed',
            type: DioExceptionType.connectionError,
          ),
        );
      }
    }

    // Add fresh token to request
    final token = await TokenManager.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      log("🔐 Added token to request: ${token.substring(0, 20)}...");
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      log("🔒 401 Unauthorized - Attempting token refresh");

      // Try to refresh the token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the original request with new token
        try {
          final token = await TokenManager.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $token';

          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          log("❌ Retry failed: $e");
          return handler.next(err);
        }
      } else {
        // Refresh failed, logout user
        log("❌ Token refresh failed, logging out");
        await _handleLogout();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  // Refresh token logic
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await TokenManager.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        log("❌ No refresh token available");
        return false;
      }

      log("📡 Calling refresh token API: $refreshTokenEndpoint");

      final response = await _dio.post(
        refreshTokenEndpoint,
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Update tokens
        await TokenManager.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'] ?? refreshToken,
          expiresIn: data['expiresIn'] ?? 3600,
        );

        log("✅ Token refreshed successfully");
        return true;
      } else {
        log("❌ Refresh token failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("❌ Token refresh error: $e");
      return false;
    }
  }

  // Handle logout
  Future<void> _handleLogout() async {
    await TokenManager.clearTokens();
    await SharedPreferencesHelper.clearAllUserData();
    onTokenRefreshFailed?.call();
  }
}