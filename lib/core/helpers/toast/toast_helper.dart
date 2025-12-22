// lib/core/helpers/toast_helper.dart
import 'package:flutter/material.dart';

class ToastHelper {
  /// Show success toast message
  static void success({
    required String message,
    String? description,
    required BuildContext context,
  }) {
    _showCustomSnackBar(
      context: context,
      message: message,
      description: description,
      backgroundColor: const Color(0xFF10B981),
      icon: Icons.check_circle_rounded,
      iconColor: Colors.white,
    );
  }

  /// Show error toast message
  static void error({
    required String message,
    String? description,
    required BuildContext context,
  }) {
    _showCustomSnackBar(
      context: context,
      message: message,
      description: description,
      backgroundColor: const Color(0xFFEF4444),
      icon: Icons.error_rounded,
      iconColor: Colors.white,
    );
  }

  /// Show info toast message
  static void info({
    required String message,
    String? description,
    required BuildContext context,
  }) {
    _showCustomSnackBar(
      context: context,
      message: message,
      description: description,
      backgroundColor: const Color(0xFF3B82F6),
      icon: Icons.info_rounded,
      iconColor: Colors.white,
    );
  }

  /// Show warning toast message
  static void warning({
    required String message,
    String? description,
    required BuildContext context,
  }) {
    _showCustomSnackBar(
      context: context,
      message: message,
      description: description,
      backgroundColor: const Color(0xFFFBBF24),
      icon: Icons.warning_rounded,
      iconColor: Colors.black87,
      textColor: Colors.black87,
    );
  }

  /// Show custom toast message
  static void custom({
    required BuildContext context,
    required String message,
    String? description,
    required Color backgroundColor,
    required IconData icon,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
  }) {
    _showCustomSnackBar(
      context: context,
      message: message,
      description: description,
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
    );
  }

  /// Internal method to show custom styled snackbar
  /// Internal method to show custom styled TOP toast using Overlay
  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    String? description,
    required Color backgroundColor,
    required IconData icon,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
  }) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (description != null && description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              color: textColor.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                         

                      ],
                    ),
                  ),
                  // Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => overlayEntry.remove(),
                    child: const Icon(Icons.close, color: Colors.white, size: 24),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    // Auto dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }
}