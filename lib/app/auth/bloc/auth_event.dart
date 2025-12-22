// lib/app/auth/bloc/auth_event.dart
import 'dart:io';

abstract class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String fullName;
  final String phone;
  final String email;
  final File? profileImage;
  final String aadharId;
  final String abhaId;
  final Map<String, dynamic> address;
  final List<Map<String, dynamic>> emergencyContacts;

  SignUpRequested({
    required this.fullName,
    required this.phone,
    required this.email,
    this.profileImage,
    required this.aadharId,
    required this.abhaId,
    required this.address,
    required this.emergencyContacts,
  });
}

class GenerateOtpRequested extends AuthEvent {
  final String phone;

  GenerateOtpRequested({required this.phone});
}

class VerifyOtpRequested extends AuthEvent {
  final String phone;
  final String otp;

  VerifyOtpRequested({
    required this.phone,
    required this.otp,
  });
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}

class PasswordVisibilityToggled extends AuthEvent {}

class ConfirmPasswordVisibilityToggled extends AuthEvent {}

class OtpFieldChanged extends AuthEvent {
  final String otp;

  OtpFieldChanged({required this.otp});
}