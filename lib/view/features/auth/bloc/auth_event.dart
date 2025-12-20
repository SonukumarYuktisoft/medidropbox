abstract class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpRequested({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
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