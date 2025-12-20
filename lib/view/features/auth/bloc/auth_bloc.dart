import 'package:bloc/bloc.dart';
import 'package:medidropbox/view/features/auth/SignupScreen/signup_screen.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_event.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // Validate password match
      if (event.password != event.confirmPassword) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Passwords do not match',
        ));
        return;
      }

      // Validate password strength
      if (event.password.length < 6) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Password must be at least 6 characters',
        ));
        return;
      }

      // Validate email format
      if (!_isValidEmail(event.email)) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Please enter a valid email',
        ));
        return;
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final result = await authRepository.signUp(
      //   username: event.username,
      //   email: event.email,
      //   phone: event.phone,
      //   password: event.password,
      // );

      emit(state.copyWith(
        status: AuthStatus.success,
        username: event.username,
        email: event.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // Validate email format
      if (!_isValidEmail(event.email)) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Please enter a valid email',
        ));
        return;
      }

      // Validate password
      if (event.password.isEmpty) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Please enter your password',
        ));
        return;
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final result = await authRepository.login(
      //   email: event.email,
      //   password: event.password,
      // );

      emit(state.copyWith(
        status: AuthStatus.success,
        email: event.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthState.initial());
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordVisibilityToggled(
    ConfirmPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}