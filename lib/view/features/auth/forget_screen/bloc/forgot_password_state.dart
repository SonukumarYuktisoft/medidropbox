enum ForgotPasswordStatus { initial, loading, emailSent, passwordReset, failure }

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final String? errorMessage;
  final String? email;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  ForgotPasswordState({
    required this.status,
    this.errorMessage,
    this.email,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      status: ForgotPasswordStatus.initial,
      obscurePassword: true,
      obscureConfirmPassword: true,
    );
  }

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? errorMessage,
    String? email,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      email: email ?? this.email,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}