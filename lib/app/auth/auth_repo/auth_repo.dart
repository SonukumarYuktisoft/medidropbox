// lib/app/auth/auth_repo/auth_repo.dart
import 'dart:io';

abstract class AuthRepo {
  /// Register a new patient
  Future<Map<String, dynamic>> registerPatient({
    required String fullName,
    required String phone,
    required String email,
    File? profileImage,
    required String aadharId,
    required String abhaId,
    required Map<String, dynamic> address,
    required List<Map<String, dynamic>> emergencyContacts,
  });

  /// Generate OTP for phone number
  Future<Map<String, dynamic>> generateOtp({
    required String phone,
  });

  /// Verify OTP and login
  Future<Map<String, dynamic>> verifyOtpAndLogin({
    required String phone,
    required String otp,
  });

  /// Logout user
  Future<void> logout();
}