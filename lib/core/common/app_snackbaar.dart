// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:medidropbox/navigator/app_navigators/app_key.dart';
class AppSnackbar {
  // Error Snackbar
  static void showError(String message, {Duration duration = const Duration(seconds: 3)}) {
    _clearAndShowSnackbar(
      message: message,
      backgroundColor: const Color(0xFFDC2626),
      icon: Icons.error_outline,
      iconColor: Colors.white,
      duration: duration,
    );
  }

  // Success Snackbar
  static void showSuccess(String message, {Duration duration = const Duration(seconds: 3)}) {
    _clearAndShowSnackbar(
      message: message,
      backgroundColor: const Color(0xFF16A34A),
      icon: Icons.check_circle_outline,
      iconColor: Colors.white,
      duration: duration,
    );
  }

  // Info Snackbar
  static void showInfo(String message, {Duration duration = const Duration(seconds: 3)}) {
    _clearAndShowSnackbar(
      message: message,
      backgroundColor: const Color(0xFF2563EB),
      icon: Icons.info_outline,
      iconColor: Colors.white,
      duration: duration,
    );
  }

  // Warning Snackbar
  static void showWarning(String message, {Duration duration = const Duration(seconds: 3)}) {
    _clearAndShowSnackbar(
      message: message,
      backgroundColor: const Color(0xFFF59E0B),
      icon: Icons.warning_amber_outlined,
      iconColor: Colors.white,
      duration: duration,
    );
  }

  // Custom Snackbar
  static void showCustom({
    required String message,
    Color backgroundColor = Colors.black87,
    IconData? icon,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    _clearAndShowSnackbar(
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
      duration: duration,
    );
  }

  // Clear any existing snackbar before showing new one
  static void _clearAndShowSnackbar({
    required String message,
    required Color backgroundColor,
    IconData? icon,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Remove any existing snackbar first
    AppKey.scaffoldMessengerKey.currentState?.clearSnackBars();
    
    // Show the new snackbar
    _showSnackbar(
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
      duration: duration,
    );
  }

  // Private method to build and show snackbar
  static void _showSnackbar({
    required String message,
    required Color backgroundColor,
    IconData? icon,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    AppKey.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: duration,
        elevation: 6,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: textColor.withOpacity(0.8),
          onPressed: () {
            AppKey.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Method to manually clear all snackbars
  static void clearAll() {
    AppKey.scaffoldMessengerKey.currentState?.clearSnackBars();
  }
}
// Usage Examples:
// AppSnackbar.showError('Failed to load data');
// AppSnackbar.showSuccess('Profile updated successfully');
// AppSnackbar.showInfo('Check your internet connection');
// AppSnackbar.showWarning('Your session is about to expire');
// AppSnackbar.showCustom(
//   message: 'Custom message',
//   backgroundColor: Colors.purple,
//   icon: Icons.celebration,
// );