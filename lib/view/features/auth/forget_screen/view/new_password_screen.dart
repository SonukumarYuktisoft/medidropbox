import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_bloc.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_event.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_state.dart';
import 'package:medidropbox/view/features/auth/forget_screen/view/passwordChanged_success_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.passwordReset) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const PasswordChangedSuccessScreen(),
            ),
          );
        } else if (state.status == ForgotPasswordStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF6366F1),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Please create a new password that you don\'t use on any other site.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _newPasswordController,
                            obscureText: state.obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Create new password',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  context.read<ForgotPasswordBloc>().add(
                                    ForgotPasswordVisibilityToggled(),
                                  );
                                },
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF9FAFB),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6366F1),
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: state.obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm your password',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  context.read<ForgotPasswordBloc>().add(
                                    ForgotConfirmPasswordVisibilityToggled(),
                                  );
                                },
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF9FAFB),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6366F1),
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed:
                                  state.status == ForgotPasswordStatus.loading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<ForgotPasswordBloc>().add(
                                          ResetPasswordSubmitted(
                                            newPassword:
                                                _newPasswordController.text,
                                            confirmPassword:
                                                _confirmPasswordController.text,
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child:
                                  state.status == ForgotPasswordStatus.loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Change',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
