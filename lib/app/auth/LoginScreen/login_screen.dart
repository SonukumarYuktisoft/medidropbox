import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/app/auth/bloc/auth_bloc.dart';
import 'package:medidropbox/app/auth/bloc/auth_event.dart';
import 'package:medidropbox/app/auth/bloc/auth_state.dart';
import 'package:medidropbox/app/auth/OtpScreen/otp_screen.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/extensions/space_extension.dart';
import 'package:medidropbox/core/extensions/url_launcher_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

import 'package:medidropbox/core/validator/validator_helper.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneLoginView();
  }
}

class PhoneLoginView extends StatefulWidget {
  const PhoneLoginView({super.key});

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleGenerateOtp() {
    if (_formKey.currentState!.validate()) {
      final phone = '+91-${_phoneController.text}';
      context.read<AuthBloc>().add(GenerateOtpRequested(phone: phone));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          // Navigate to OTP screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(phoneNumber: '+91-${_phoneController.text}'),
            ),
          );
        } else if (state.status == AuthStatus.failure) {
          AppSnackbar.showError( state.errorMessage ?? 'Failed to send OTP');
         
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.heightBox,
                    // Logo or Icon
                    // Center(child: AuthConstantsString.authLogo.toCircularSvgAssetImage(
                    //   size: 100
                    // )),
                    Icon(Icons.call,size: 60),
                    40.heightBox,

                    Text(
                      'Welcome Back',
                      style:
                          textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ) ??
                          const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your phone number to receive OTP',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    40.heightBox,

                    // Phone Number Input
                    CommonTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hintText: '9876543210',
                      prefixIcon: Icon(
                        FontAwesomeIcons.phone,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      keyboardType: TextInputType.phone,
                      digitsOnly: true,
                      maxLength: 10,
                      validator:ValidatorHelper.isValidPhoneNumber
                    ),
                    40.heightBox,

                    // Generate OTP Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : _handleGenerateOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.status == AuthStatus.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Send OTP',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    20.heightBox,

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      TextButton(onPressed:() {
                         AppNavigators.push(AppRoutesPath.signup);
                      } , child: const Text('Sign up')),
                        
                      ],
                    ),
                    40.heightBox,

                    // Terms and Privacy
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                            children: [
                              const TextSpan(
                                text: 'By continuing, you agree to our ',
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
