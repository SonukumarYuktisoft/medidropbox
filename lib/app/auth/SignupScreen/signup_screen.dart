import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medidropbox/app/auth/SignupScreen/widgets/address_input_widget.dart';
import 'package:medidropbox/app/auth/SignupScreen/widgets/emergency_contact_widget.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/app/auth/bloc/auth_bloc.dart';
import 'package:medidropbox/app/auth/bloc/auth_event.dart';
import 'package:medidropbox/app/auth/bloc/auth_state.dart';
import 'package:medidropbox/app/auth/bloc/profile_image_cubit.dart';
import 'package:medidropbox/app/auth/widgets/profile_image_picker_widget.dart';
import 'package:medidropbox/core/extensions/space_extension.dart';
import 'package:medidropbox/core/helpers/toast/toast_helper.dart';
import 'package:medidropbox/core/validator/validator_helper.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_name.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupView();
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aadharIdController = TextEditingController();
  final _abhaIdController = TextEditingController();

  File? _profileImage;
  Map<String, dynamic> _addressData = {};
  Map<String, dynamic> _emergencyContactData = {};

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _aadharIdController.dispose();
    _abhaIdController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // Get the selected image from ProfileImageCubit
      final profileImageCubit = context.read<ProfileImageCubit>();
      final selectedImage = profileImageCubit.getSelectedImage();

      // Validate that required data is present
      if (_addressData.isEmpty ||
          _addressData['addressLine1']?.isEmpty == true) {
        ToastHelper.error(
          message: 'Please fill in the address details',
          context: context,
        );
        return;
      }

      if (_emergencyContactData.isEmpty ||
          _emergencyContactData['personName']?.isEmpty == true) {
        ToastHelper.error(
          message: 'Please fill in the emergency contact details',
          context: context,
        );

        return;
      }

      context.read<AuthBloc>().add(
        SignUpRequested(
          fullName: _fullNameController.text,
          phone: '+91-${_phoneController.text}',
          email: _emailController.text,
          profileImage: selectedImage,
          aadharId: _aadharIdController.text,
          abhaId: _abhaIdController.text,
          address: _addressData,
          emergencyContacts: [_emergencyContactData],
        ),
      );
    }
  }

  void _showError(String message) {
    ToastHelper.error(message: message, context: context);
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          ToastHelper.success(message: 'Sign up successful!', context: context);

          AppNavigators.pushReplacementNamed(AppRoutesName.dashboardView);
        } else if (state.status == AuthStatus.failure) {
          ToastHelper.error(
            message: state.errorMessage ?? 'Sign up failed',
            context: context,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surface,
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
                    20.heightBox,

                    // Header
                    Text(
                      'Create Account',
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
                    8.heightBox,
                    Row(
                      children: [
                        Text(
                          'Already have an account? ',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AppNavigators.pop(),
                          child: Text(
                            'Sign In!',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    30.heightBox,

                    // Profile Image Picker with BLoC
                    BlocBuilder<ProfileImageCubit, ProfileImageState>(
                      builder: (context, state) {
                        return ProfileImagePickerWidget(
                          onImageSelected: (image) {
                            setState(() {
                              _profileImage = image;
                            });
                          },
                          initialImage: _profileImage,
                        );
                      },
                    ),
                    30.heightBox,

                    // Personal Information Section
                    _buildSectionHeader(
                      'Personal Information',
                      colorScheme,
                      textTheme,
                    ),
                    16.heightBox,

                    CommonTextField(
                      controller: _fullNameController,
                      label: 'Full Name',
                      hintText: 'John Doe',
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      validator: ValidatorHelper.isValidUsername,
                    ),
                    16.heightBox,

                    CommonTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'john.doe@example.com',
                      prefixIcon: Icon(
                        FontAwesomeIcons.envelope,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidatorHelper.isValidEmail,
                    ),
                    16.heightBox,

                    CommonTextField(
                      controller: _phoneController,
                      label: 'Phone',
                      hintText: '9876543210',
                      prefixIcon: Icon(
                        FontAwesomeIcons.phone,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      keyboardType: TextInputType.phone,
                      digitsOnly: true,
                      maxLength: 10,
                      validator: ValidatorHelper.isValidPhoneNumber,
                    ),
                    16.heightBox,

                    CommonTextField(
                      controller: _abhaIdController,
                      label: 'ABHA ID',
                      hintText: 'ABHA123456789',
                      prefixIcon: Icon(
                        FontAwesomeIcons.idBadge,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      validator: ValidatorHelper.isValidAadhar,
                    ),
                    30.heightBox,

                    // Address Section
                    AddressInputWidget(
                      onAddressChanged: (address) {
                        setState(() {
                          _addressData = address;
                        });
                      },
                    ),
                    30.heightBox,

                    // Emergency Contact Section
                    EmergencyContactWidget(
                      onContactChanged: (contact) {
                        setState(() {
                          _emergencyContactData = contact;
                        });
                      },
                    ),
                    40.heightBox,

                    // Sign Up Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : _handleSignup,
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
                                    'Sign Up',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    40.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Text(
      title,
      style:
          textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ) ??
          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
