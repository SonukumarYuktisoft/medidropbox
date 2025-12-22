import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      return null;
    }
  }

  /// Pick image from camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
      return null;
    }
  }

  /// Show bottom sheet to choose image source
  static Future<File?> showImageSourceBottomSheet(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: isDark
                    ? colorScheme.onSurface.withOpacity(0.3)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Title
            Text(
              'Choose Image Source',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ) ?? const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Gallery Option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.photo_library,
                  color: colorScheme.primary,
                ),
              ),
              title: Text(
                'Gallery',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Choose from your photos',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              onTap: () async {
                final image = await pickImageFromGallery();
                if (context.mounted) {
                  Navigator.pop(context, image);
                }
              },
            ),
            const SizedBox(height: 10),
            
            // Camera Option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: colorScheme.primary,
                ),
              ),
              title: Text(
                'Camera',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Take a new photo',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              onTap: () async {
                final image = await pickImageFromCamera();
                if (context.mounted) {
                  Navigator.pop(context, image);
                }
              },
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}