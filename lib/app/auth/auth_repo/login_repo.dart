// lib/app/auth/auth_repo/login_repo.dart
import 'dart:io';
import 'dart:developer' show log;
import 'package:medidropbox/app/auth/auth_repo/auth_repo.dart';
import 'package:medidropbox/app/services/api_service.dart';
import 'package:medidropbox/app/services/app_config.dart';
import 'package:medidropbox/app/services/shared_preferences_helper.dart';


class LoginRepo implements AuthRepo {
  final ApiService _apiService = ApiService();
  final AppConfig _appConfig = AppConfig();

  @override
  Future<Map<String, dynamic>> generateOtp({
    required String phone,
  }) async {
    try {
      final response = await _apiService.requestPostForApi(
        url: _appConfig.generateOtp,
        dictParameter: {'phone': phone},
        authToken: false,
      );

      if (response == null) {
        return {
          'success': false,
          'message': 'No response from server',
        };
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✅ OTP generated successfully');
        return {
          'success': true,
          'message': 'OTP sent successfully',
          'data': response.data,
        };
      } else {
        log('❌ OTP generation failed: ${response.statusMessage}');
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to generate OTP',
          'statusCode': response.statusCode,
        };
      }
    } catch (e, s) {
      log('❌ OTP generation exception: $e');
      log('Stacktrace: $s');
      return {
        'success': false,
        'message': 'An error occurred while generating OTP',
        'error': e.toString(),
      };
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOtpAndLogin({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _apiService.requestPostForApi(
        url: _appConfig.verifyOtpAndLogin,
        dictParameter: {
          'phone': phone,
          'otp': otp,
        },
        authToken: false,
      );

      if (response == null) {
        return {
          'success': false,
          'message': 'No response from server',
        };
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✅ OTP verified and logged in successfully');
        
        // Extract accessToken from response
        String? accessToken = response.data['accessToken'] ?? response.data['data']?['accessToken'];
        
        // Save accessToken to SharedPreferences
        if (accessToken != null) {
          await SharedPreferencesHelper.setUserToken(accessToken);
          log('✅ Token saved to SharedPreferences');
        }
        
        return {
          'success': true,
          'message': 'Login successful',
          'accessToken': accessToken,
          'data': response.data,
        };
      } else {
        log('❌ OTP verification failed: ${response.statusMessage}');
        return {
          'success': false,
          'message': response.data['message'] ?? 'Invalid OTP',
          'statusCode': response.statusCode,
        };
      }
    } catch (e, s) {
      log('❌ OTP verification exception: $e');
      log('Stacktrace: $s');
      return {
        'success': false,
        'message': 'An error occurred during login',
        'error': e.toString(),
      };
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Clear user accessToken and any cached data
      await SharedPreferencesHelper.clearUserToken();
      log('✅ User logged out successfully');
    } catch (e) {
      log('❌ Logout exception: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> registerPatient({
    required String fullName,
    required String phone,
    required String email,
    File? profileImage,
    required String aadharId,
    required String abhaId,
    required Map<String, dynamic> address,
    required List<Map<String, dynamic>> emergencyContacts,
  }) async {
    throw UnimplementedError('Registration is handled by SignupRepo');
  }
}