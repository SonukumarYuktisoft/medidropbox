import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/core/validator/validator_helper.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_bloc.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_event.dart';
import 'package:medidropbox/view/features/auth/forget_screen/bloc/forgot_password_state.dart';
import 'package:medidropbox/view/features/auth/forget_screen/view/new_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.emailSent) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ForgotPasswordBloc>(),
                child: const NewPasswordScreen(),
              ),
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Enter your email address',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CommonTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter email address',
                        label: 'Email',
                        validator: ValidatorHelper.isValidEmail,
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
                                          ForgotPasswordEmailSubmitted(
                                            _emailController.text.trim(),
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
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
                                      'Continue',
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
