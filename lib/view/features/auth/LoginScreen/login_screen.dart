import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/routes/app_pages.dart';
import 'package:medidropbox/routes/app_routes.dart';
import 'package:medidropbox/view/features/auth/SignupScreen/signup_screen.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_bloc.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_event.dart';
import 'package:medidropbox/view/features/auth/bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthBloc(), child: const LoginView());
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to home screen
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Login failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE8F0FE),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            // TextButton(onPressed: () {
                            //   context.go(AppRoutes.signupScreen);
                            // }, child: Text('Sign Up', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: context.theme.primaryColor))),
  
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const SignupScreen(),
                                //   ),
                                // );
                                context.push(
                                  AppRoutes.signupScreen
                                );
                              },
                              child: const Text(
                                'Sign Up!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        CommonTextField(
                          controller: _emailController,
                          label: 'Email',
                          hintText: 'shahanuzzaman23@gmail.com',
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          focusNode: FocusNode(canRequestFocus: true),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return CommonTextField(
                              controller: _passwordController,
                              label: 'Password',
                              hintText: '••••••••',
                              prefixIcon: Icon(FontAwesomeIcons.lock),
                              obscureText: state.obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    PasswordVisibilityToggled(),
                                  );
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRoutes.forgetScreen);
                            },
                            child: const Text(
                              'Forgot your Password?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: state.status == AuthStatus.loading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                            LoginRequested(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: state.status == AuthStatus.loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
