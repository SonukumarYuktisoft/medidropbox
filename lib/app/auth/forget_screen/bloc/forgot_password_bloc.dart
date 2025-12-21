import 'package:bloc/bloc.dart';
import 'package:medidropbox/app/auth/forget_screen/bloc/forgot_password_event.dart';
import 'package:medidropbox/app/auth/forget_screen/bloc/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState.initial()) {
    on<ForgotPasswordEmailSubmitted>(_onEmailSubmitted);
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
    on<ForgotPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<ForgotConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
  }

  Future<void> _onEmailSubmitted(
    ForgotPasswordEmailSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      // Validate email format
      if (!_isValidEmail(event.email)) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: 'Please enter a valid email',
        ));
        return;
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // await authRepository.sendPasswordResetEmail(event.email);

      emit(state.copyWith(
        status: ForgotPasswordStatus.emailSent,
        email: event.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: 'Failed to send reset email. Please try again.',
      ));
    }
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      // Validate password match
      if (event.newPassword != event.confirmPassword) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: 'Passwords do not match',
        ));
        return;
      }

      // Validate password strength
      if (event.newPassword.length < 6) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: 'Password must be at least 6 characters',
        ));
        return;
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // await authRepository.resetPassword(event.newPassword);

      emit(state.copyWith(status: ForgotPasswordStatus.passwordReset));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: 'Failed to reset password. Please try again.',
      ));
    }
  }

  void _onPasswordVisibilityToggled(
    ForgotPasswordVisibilityToggled event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordVisibilityToggled(
    ForgotConfirmPasswordVisibilityToggled event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}