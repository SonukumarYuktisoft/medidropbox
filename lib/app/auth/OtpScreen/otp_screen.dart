import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/core/helpers/toast/toast_helper.dart';
import 'package:pinput/pinput.dart';
import 'package:medidropbox/app/auth/bloc/auth_bloc.dart';
import 'package:medidropbox/app/auth/bloc/auth_event.dart';
import 'package:medidropbox/app/auth/bloc/auth_state.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: OtpView(phoneNumber: phoneNumber),
    );
  }
}

class OtpView extends StatefulWidget {
  final String phoneNumber;

  const OtpView({super.key, required this.phoneNumber});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with SingleTickerProviderStateMixin {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int _resendTimer = 60;
  Timer? _timer;
  bool _canResend = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _setupAnimations();

    // Auto-focus on the PIN input
    Future.delayed(const Duration(milliseconds: 500), () {
      _focusNode.requestFocus();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _resendTimer = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_resendTimer > 0) {
            _resendTimer--;
          } else {
            _canResend = true;
            _timer?.cancel();
          }
        });
      }
    });
  }

  void _handleResendOtp() {
    if (_canResend) {
      context.read<AuthBloc>().add(
        GenerateOtpRequested(phone: widget.phoneNumber),
      );
      _startTimer();
      _pinController.clear();
    }
  }

  Future<void> _handleVerifyOtp(String otp) async {
    if (otp.length == 4) {
      context.read<AuthBloc>().add(
        VerifyOtpRequested(phone: widget.phoneNumber, otp: otp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    // Pinput theme configuration
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? colorScheme.onSurface.withOpacity(0.2)
              : const Color(0xFFE5E7EB),
          width: 1.5,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: colorScheme.primary, width: 2),
      boxShadow: [
        BoxShadow(
          color: colorScheme.primary.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: colorScheme.primary.withOpacity(0.1),
        border: Border.all(color: colorScheme.primary, width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: colorScheme.error, width: 1.5),
      ),
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.status == AuthStatus.otpVerified) {
          // Save authentication data
          if (state.accessToken != null) {
            await SharedPreferencesHelper.setUserToken(state.accessToken!);
            await SharedPreferencesHelper.setLoginStatus(true);
          }

          if (mounted) {
            // Show success animation/feedback
            ToastHelper.success(
              message: 'Verification successful!',
              context: context,
            );

            await Future.delayed(const Duration(milliseconds: 500));
            AppNavigators.pushReplacementNamed(AppRoutesName.dashboardView);
          }
        } else if (state.status == AuthStatus.otpSent) {
          ToastHelper.success(
            message: 'OTP sent successfully!',
            context: context,
          );
        } else if (state.status == AuthStatus.failure) {
          ToastHelper.error(
            message: state.errorMessage ?? 'Verification failed',
            context: context,
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onSurface,
                size: 20,
              ),
            ),
            onPressed: () => AppNavigators.pop(),
          ),
        ),
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Animated Illustration
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  colorScheme.primary.withOpacity(0.2),
                                  colorScheme.primary.withOpacity(0.05),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              FontAwesomeIcons.mobileScreen,
                              size: 60,
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Title
                    Text(
                      'OTP Verification',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description
                    Text(
                      'Enter the verification code we just sent to',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.phoneNumber,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Pinput OTP Input
                    Pinput(
                      controller: _pinController,
                      focusNode: _focusNode,
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      errorPinTheme: errorPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      cursor: Container(
                        width: 2,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      onCompleted: _handleVerifyOtp,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.easeInOut,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code? ",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleResendOtp,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _canResend
                                  ? colorScheme.primary.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                if (!_canResend) ...[
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 16,
                                    color: colorScheme.onSurface.withOpacity(
                                      0.4,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  _canResend
                                      ? 'Resend OTP'
                                      : '${_resendTimer}s',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: _canResend
                                        ? colorScheme.primary
                                        : colorScheme.onSurface.withOpacity(
                                            0.4,
                                          ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Verify Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : () => _handleVerifyOtp(_pinController.text),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 0,
                              disabledBackgroundColor: colorScheme.primary
                                  .withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadowColor: colorScheme.primary.withOpacity(0.3),
                            ),
                            child: state.status == AuthStatus.loading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: colorScheme.onPrimary,
                                          strokeWidth: 2.5,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Verifying...',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Verify & Continue',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Security Note
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? colorScheme.surface
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? colorScheme.onSurface.withOpacity(0.1)
                              : Colors.blue.shade100,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.security,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Never share your OTP with anyone for security purposes',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
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
