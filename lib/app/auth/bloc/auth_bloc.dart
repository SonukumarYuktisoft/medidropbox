// lib/app/auth/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:medidropbox/app/auth/auth_repo/signup_repo.dart';
import 'package:medidropbox/app/auth/auth_repo/login_repo.dart';
import 'package:medidropbox/app/auth/bloc/auth_event.dart';
import 'package:medidropbox/app/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupRepo _signupRepo = SignupRepo();
  final LoginRepo _loginRepo = LoginRepo();

  AuthBloc() : super(AuthState.initial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<GenerateOtpRequested>(_onGenerateOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
    on<OtpFieldChanged>(_onOtpFieldChanged);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // Validate email format
      // if (_isValidEmail(event.email)) {
      //   emit(
      //     state.copyWith(
      //       status: AuthStatus.failure,
      //       errorMessage: 'Please enter a valid email',
      //     ),
      //   );
      //   return;
      // }

      // Validate phone format
      if (_isValidPhone(event.phone)) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: 'Please enter a valid phone number',
          ),
        );
        return;
      }

      // Validate Aadhar ID (12 digits)
      if (event.aadharId.length != 12) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: 'Aadhar ID must be 12 digits',
          ),
        );
        return;
      }

      // Call repository to register patient
      final result = await _signupRepo.registerPatient(
        fullName: event.fullName,
        phone: event.phone,
        email: event.email,
        profileImage: event.profileImage,
        aadharId: event.aadharId,
        abhaId: event.abhaId,
        address: event.address,
        emergencyContacts: event.emergencyContacts,
      );

      if (result['success'] == true) {
        emit(
          state.copyWith(
            status: AuthStatus.success,
            fullName: event.fullName,
            email: event.email,
            phone: event.phone,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: result['message'] ?? 'Registration failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'An error occurred: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onGenerateOtpRequested(
    GenerateOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final result = await _loginRepo.generateOtp(phone: event.phone);

      if (result['success'] == true) {
        emit(state.copyWith(status: AuthStatus.otpSent, phone: event.phone));
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: result['message'] ?? 'Failed to send OTP',
            accessToken: result['accessToken'],
            refreshToken: result['refreshToken'],
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'An error occurred: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // Validate OTP (4 digits)
      if (event.otp.length != 4) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: 'Please enter a valid 4-digit OTP',
          ),
        );
        return;
      }

      // Call repository to verify OTP and login
      final result = await _loginRepo.verifyOtpAndLogin(
        phone: event.phone,
        otp: event.otp,
      );

      if (result['success'] == true) {
        emit(
          state.copyWith(
            status: AuthStatus.otpVerified,
            phone: event.phone,
            otp: event.otp,
            accessToken: result['accessToken'],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: result['message'] ?? 'Invalid OTP',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'An error occurred: ${e.toString()}',
        ),
      );
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
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: 'Please enter a valid email',
          ),
        );
        return;
      }

      // Validate password
      if (event.password.isEmpty) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: 'Please enter your password',
          ),
        );
        return;
      }

      // TODO: Implement email/password login if needed
      emit(state.copyWith(status: AuthStatus.success, email: event.email));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _loginRepo.logout();
      emit(AuthState.initial());
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Logout failed: ${e.toString()}',
        ),
      );
    }
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

  void _onOtpFieldChanged(OtpFieldChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Remove any spaces, dashes, or country code
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\+]'), '');
    // Check if it's 10 digits
    return RegExp(r'^\d{10}$').hasMatch(cleanPhone);
  }
}
