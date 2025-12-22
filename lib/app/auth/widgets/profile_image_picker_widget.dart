import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/auth/bloc/profile_image_cubit.dart';
import 'package:medidropbox/core/helpers/image_picker_helper.dart';

class ProfileImagePickerWidget extends StatelessWidget {
  final Function(File?) onImageSelected;
  final File? initialImage;

  const ProfileImagePickerWidget({
    super.key,
    required this.onImageSelected,
    this.initialImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProfileImageCubit();
        if (initialImage != null) {
          cubit.setInitialImage(initialImage);
        }
        return cubit;
      },
      child: ProfileImagePickerView(
        onImageSelected: onImageSelected,
      ),
    );
  }
}

class ProfileImagePickerView extends StatelessWidget {
  final Function(File?) onImageSelected;

  const ProfileImagePickerView({
    super.key,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final image = await ImagePickerHelper.showImageSourceBottomSheet(context);
    if (image != null && context.mounted) {
      context.read<ProfileImageCubit>().selectImage(image);
      onImageSelected(image);
    }
  }

  void _removeImage(BuildContext context) {
    context.read<ProfileImageCubit>().removeImage();
    onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        File? selectedImage;
        
        if (state is ProfileImageSelected) {
          selectedImage = state.imageFile;
        }

        return Center(
          child: Stack(
            children: [
              // Main Image Container
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark 
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person,
                          size: 60,
                          color: isDark 
                              ? Colors.grey[600]
                              : const Color(0xFF9CA3AF),
                        ),
                ),
              ),

              // Camera Button
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),

              // Remove Button (only show when image is selected)
              if (selectedImage != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _removeImage(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.error.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: colorScheme.onError,
                      ),
                    ),
                  ),
                ),

              // Loading Indicator
              if (state is ProfileImageLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}