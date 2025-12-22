// lib/app/auth/bloc/auth_state.dart
enum AuthStatus { initial, loading, success, failure, otpSent, otpVerified }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? otp;
  final String? accessToken;
  final String ?refreshToken;

  AuthState({
    required this.status,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.fullName,
    this.email,
    this.phone,
    this.otp,
    this.accessToken,
    this.refreshToken
  });

  factory AuthState.initial() {
    return AuthState(
      status: AuthStatus.initial,
      obscurePassword: true,
      obscureConfirmPassword: true,
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? fullName,
    String? email,
    String? phone,
    String? otp,
    String? accessToken,
    String? refreshToken
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken
    );
  }
}