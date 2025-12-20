abstract class ForgotPasswordEvent {}

class ForgotPasswordEmailSubmitted extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordEmailSubmitted(this.email);
}

class ResetPasswordSubmitted extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;
  
  ResetPasswordSubmitted({
    required this.newPassword,
    required this.confirmPassword,
  });
}

class ForgotPasswordVisibilityToggled extends ForgotPasswordEvent {}

class ForgotConfirmPasswordVisibilityToggled extends ForgotPasswordEvent {}
