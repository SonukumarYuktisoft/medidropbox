import 'package:flutter/material.dart';

// Extension on String to create buttons
extension StringToButtonExtension on String {
  // Convert String to ElevatedButton
  ElevatedButton toElevatedButton({
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    double ?radius
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??20))
      ),
      child: Text(this,
       
      ),
    );
  }

  // Convert String to TextButton
  TextButton toTextButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    VoidCallback? onLongPress,
  }) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: Text(this),
    );
  }

  // Convert String to OutlinedButton
  OutlinedButton toOutlinedButton({
    required VoidCallback? onPressed,
    ButtonStyle? style,
    VoidCallback? onLongPress,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: Text(this),
    );
  }

  // Convert String to styled ElevatedButton with common parameters
  ElevatedButton toStyledElevatedButton({
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? elevation,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        elevation: elevation,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius)
            : null,
      ),
      child: Text(this),
    );
  }

  // Convert String to styled TextButton with common parameters
  TextButton toStyledTextButton({
    required VoidCallback? onPressed,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius)
            : null,
      ),
      child: Text(this),
    );
  }

  // Convert String to styled OutlinedButton with common parameters
  OutlinedButton toStyledOutlinedButton({
    required VoidCallback? onPressed,
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding,
        side: borderColor != null || borderWidth != null
            ? BorderSide(
                color: borderColor ?? Colors.grey,
                width: borderWidth ?? 1,
              )
            : null,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius)
            : null,
      ),
      child: Text(this),
    );
  }
}

// Extension for ElevatedButton
extension ElevatedButtonExtension on ElevatedButton {
  ElevatedButton withStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? maximumSize,
    BorderRadius? borderRadius,
    double? elevation,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: (style ?? ElevatedButton.styleFrom()).copyWith(
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all(backgroundColor)
            : null,
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all(foregroundColor)
            : null,
        padding: padding != null ? MaterialStateProperty.all(padding) : null,
        minimumSize: minimumSize != null
            ? MaterialStateProperty.all(minimumSize)
            : null,
        maximumSize: maximumSize != null
            ? MaterialStateProperty.all(maximumSize)
            : null,
        shape: borderRadius != null
            ? MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius),
              )
            : null,
        elevation: elevation != null
            ? MaterialStateProperty.all(elevation)
            : null,
      ),
      child: child,
    );
  }

  ElevatedButton withLoading(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      style: style,
      child: isLoading && child != null
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : child,
    );
  }
}

// Extension for TextButton
extension TextButtonExtension on TextButton {
  TextButton withStyle({
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? maximumSize,
    BorderRadius? borderRadius,
  }) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: (style ?? TextButton.styleFrom()).copyWith(
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all(foregroundColor)
            : null,
        padding: padding != null ? MaterialStateProperty.all(padding) : null,
        minimumSize: minimumSize != null
            ? MaterialStateProperty.all(minimumSize)
            : null,
        maximumSize: maximumSize != null
            ? MaterialStateProperty.all(maximumSize)
            : null,
        shape: borderRadius != null
            ? MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius),
              )
            : null,
      ),
      child: Text(child.toString()),
    );
  }

  TextButton withLoading(bool isLoading) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      style: style,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? const SizedBox(
                key: ValueKey("loader"),
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : child,
      ),
    );
  }
}

// Extension for OutlinedButton
extension OutlinedButtonExtension on OutlinedButton {
  OutlinedButton withStyle({
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? maximumSize,
    BorderRadius? borderRadius,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: (style ?? OutlinedButton.styleFrom()).copyWith(
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all(foregroundColor)
            : null,
        padding: padding != null ? MaterialStateProperty.all(padding) : null,
        minimumSize: minimumSize != null
            ? MaterialStateProperty.all(minimumSize)
            : null,
        maximumSize: maximumSize != null
            ? MaterialStateProperty.all(maximumSize)
            : null,
        side: (borderColor != null || borderWidth != null)
            ? MaterialStateProperty.all(
                BorderSide(
                  color: borderColor ?? Colors.grey,
                  width: borderWidth ?? 1,
                ),
              )
            : null,
        shape: borderRadius != null
            ? MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius),
              )
            : null,
      ),
      child: child,
    );
  }

  OutlinedButton withLoading(bool isLoading) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      style: style,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : child,
    );
  }
}

// Extension for IconButton
extension IconButtonExtension on IconButton {
  IconButton withStyle({
    Color? color,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: color ?? this.color,
      iconSize: iconSize ?? this.iconSize,
      padding: padding ?? this.padding,
      style: backgroundColor != null || borderRadius != null
          ? ButtonStyle(
              backgroundColor: backgroundColor != null
                  ? MaterialStateProperty.all(backgroundColor)
                  : null,
              shape: borderRadius != null
                  ? MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: borderRadius),
                    )
                  : null,
            )
          : style,
      tooltip: tooltip,
    );
  }

  IconButton withLoading(bool isLoading) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : icon,
      color: color,
      iconSize: iconSize,
      padding: padding,
      style: style,
      tooltip: tooltip,
    );
  }
}

// Extension for FloatingActionButton
extension FloatingActionButtonExtension on FloatingActionButton {
  FloatingActionButton withStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    BorderRadius? borderRadius,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      elevation: elevation ?? this.elevation,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius)
          : shape,
      tooltip: tooltip,
      child: child,
    );
  }

  FloatingActionButton withLoading(bool isLoading) {
    return FloatingActionButton(
      onPressed: isLoading ? null : onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      shape: shape,
      tooltip: tooltip,
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : child,
    );
  }
}

// Utility extension for common button patterns
extension ButtonStyleExtension on ButtonStyle {
  ButtonStyle withRoundedCorners(double radius) {
    return copyWith(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }

  ButtonStyle withPadding(EdgeInsetsGeometry padding) {
    return copyWith(padding: MaterialStateProperty.all(padding));
  }

  ButtonStyle withSize({double? width, double? height}) {
    return copyWith(
      minimumSize: MaterialStateProperty.all(Size(width ?? 0, height ?? 0)),
    );
  }
}

// Example usage helper
class ButtonExamples extends StatelessWidget {
  const ButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // String to ElevatedButton
        'Click Me'.toElevatedButton(onPressed: () {}),

        // String to styled ElevatedButton
        'Submit'.toStyledElevatedButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),

        // String to TextButton
        'Cancel'.toTextButton(onPressed: () {}),

        // String to styled TextButton
        'Learn More'.toStyledTextButton(
          onPressed: () {},
          foregroundColor: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),

        // String to OutlinedButton
        'Outlined'.toOutlinedButton(onPressed: () {}),

        // String to styled OutlinedButton
        'Sign Up'.toStyledOutlinedButton(
          onPressed: () {},
          borderColor: Colors.green,
          borderWidth: 2,
          foregroundColor: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),

        // ElevatedButton with custom style (existing)
        ElevatedButton(onPressed: () {}, child: const Text('Button')).withStyle(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),

        // ElevatedButton with loading
        ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        ).withLoading(true),

        // Chaining String to Button with loading
        'Processing'.toElevatedButton(onPressed: () {}).withLoading(true),

        // IconButton with background
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
        ).withStyle(
          backgroundColor: Colors.red.shade50,
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),

        // FAB with loading
        FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ).withLoading(false),
      ],
    );
  }
}
