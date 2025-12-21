import 'package:flutter/material.dart';

extension ButtonExtension on Widget {
  /// Wraps the widget in an ElevatedButton
  Widget asElevatedButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    double? width,
    double? height,
  }) {
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      child: this,
    );
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }

  /// Wraps the widget in a TextButton
  Widget asTextButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    double? width,
    double? height,
  }) {
    Widget button = TextButton(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      child: this,
    );
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }

  /// Wraps the widget in an OutlinedButton
  Widget asOutlinedButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    double? width,
    double? height,
  }) {
    Widget button = OutlinedButton(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      child: this,
    );
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }

  /// Wraps the widget in an IconButton
  Widget asIconButton({
    required VoidCallback? onPressed,
    double? iconSize,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Color? disabledColor,
    EdgeInsetsGeometry? padding,
    String? tooltip,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: this,
      iconSize: iconSize,
      color: color,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      disabledColor: disabledColor,
      padding: padding ?? const EdgeInsets.all(8.0),
      tooltip: tooltip,
    );
  }

  /// Wraps the widget in a FilledButton
  Widget asFilledButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    double? width,
    double? height,
    Color ? color
  }) {
    Widget button = FilledButton(
      
      onPressed: onPressed,
      style: style??ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(color),
        padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(0))
      ),
      focusNode: focusNode,
      autofocus: autofocus,
      child: this,
    );
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }

  /// Wraps the widget in an InkWell for custom tap handling
  Widget asButton({
    required VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius,
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: this,
    );
  }

  /// Wraps the widget in a GestureDetector for gesture handling
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  /// Creates a button with padding
  Widget asButtonWithPadding({
    required VoidCallback? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    Color? backgroundColor,
    Color? foregroundColor,
    BorderRadius? borderRadius,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      child: this,
    );
  }

  /// Creates a rounded button
  Widget asRoundedButton({
    required VoidCallback? onPressed,
    double borderRadius = 24,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
       double? width,
    double? height,
  }) {
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: this,
    );
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
      
      }
      return button;

  }

  /// Creates a circular button (for icons)
  Widget asCircularButton({
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    double size = 56,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: this,
      ),
    );
  }
}
