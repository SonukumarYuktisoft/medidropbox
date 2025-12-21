import 'package:flutter/material.dart';

class BottomSheetHelper {
  // Show simple bottom sheet
  static void show(
    BuildContext context, {
    String? title,
    Widget? content,
    String? confirmText,
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
    bool dismissible = true,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: dismissible,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (content != null) ...[
                  SizedBox(height: 10),
                  content,
                ],
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cancelText != null)
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          if (onCancel != null) onCancel();
                        },
                        child: Text(cancelText),
                      ),
                    if (confirmText != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          if (onConfirm != null) onConfirm();
                        },
                        child: Text(confirmText),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
