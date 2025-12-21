enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? username;
  final String? email;

  AuthState({
    required this.status,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.username,
    this.email,
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
    String? username,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}
