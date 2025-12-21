import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';
extension TextExtension on String {
  /// Converts the string to a title case format.
  /// Example: "hello world" -> "Hello World"
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) {
          return word.length > 1
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word.toUpperCase();
        })
        .join(' ');
  }

  /// Creates a Text widget with heading style using Poppins font.
  /// 
  /// Returns an empty SizedBox if string is empty.
  Widget toHeadingText({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    FontStyle? fontStyle,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (isEmpty) return const SizedBox.shrink();
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontStyle: fontStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈 Use appFontStyle if fontWeight is null
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }

  /// Creates a Text widget with underline decoration.
  Widget toUnderLineText({
    Color color = Colors.black,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (isEmpty) return const SizedBox.shrink();
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(
        decorationColor: color,
        decoration: TextDecoration.underline,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
      ),
    );
  }

  /// Creates a Text widget with line-through decoration.
  Widget toLineThroughText({
    Color color = Colors.black,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (isEmpty) return const SizedBox.shrink();
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(
        decoration: TextDecoration.lineThrough,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
      ),
    );
  }

  /// Creates a Text widget with limited number of lines and ellipsis overflow.
  /// 
  /// [maxLines] - Maximum number of lines to display (default: 3)
  /// [overflow] - How to handle text overflow (default: ellipsis)
  Widget toLimitLineText({
    Color color = Colors.black,
    double? fontSize,
    int maxLines = 3,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    TextAlign? textAlign,
    TextOverflow overflow = TextOverflow.ellipsis,
    double? lineHeight,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    if (isEmpty) return const SizedBox.shrink();

    return Text(
      this,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
        height: lineHeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
      ),
    );
  }

  /// Creates a Text widget with shadow effect.
  /// 
  /// [textScale] - Scale factor for text size (default: 1.0)
  /// [blurRadius] - Shadow blur radius (default: 3.0)
  /// [dx] - Horizontal shadow offset (default: 1.0)
  /// [dy] - Vertical shadow offset (default: 1.0)
  Widget toShadowText({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    TextAlign? textAlign,
    double blurRadius = 3.0,
    double dx = 1.0,
    double dy = 1.0,
    Color shadowColor = Colors.black54,
    double? letterSpacing,
    double textScale = 1.0,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (isEmpty) return const SizedBox.shrink();
    return Text(
      this,
      textAlign: textAlign,
      textScaler: TextScaler.linear(textScale),
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
        height: height,
        letterSpacing: letterSpacing,
        shadows: [
          Shadow(
            offset: Offset(dx, dy),
            blurRadius: blurRadius,
            color: shadowColor,
          ),
        ],
      ),
    );
  }

  /// Creates a Text widget with gradient color effect.
  /// 
  /// Useful for creating eye-catching headings or special text.
  Widget toGradientText({
    required Gradient gradient,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (isEmpty) return const SizedBox.shrink();
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.poppins(
          color: Colors.white, // Color is overridden by shader
          fontSize: fontSize,
          fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
        ),
      ),
    );
  }
}

extension TextStyleExtension on TextStyle {
  /// Creates a new TextStyle with Poppins font and specified properties.
  TextStyle appTextStyle({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    AppFontStyle? appFontStyle, // 👈 Added
  }) {
    return GoogleFonts.poppins(
      decoration: decoration,
      color: color ?? Colors.black,
      fontSize: fontSize,
      fontWeight: fontWeight ?? appFontStyle?.fontWeight, // 👈
    );
  }

  /// Creates a copy of this TextStyle with a new font size.
  TextStyle withFontSize(double fontSize) {
    return copyWith(fontSize: fontSize);
  }

  /// Creates a copy of this TextStyle with a new font weight.
  TextStyle withFontWeight(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }

  /// Creates a copy of this TextStyle with AppFontStyle.
  TextStyle withAppFontStyle(AppFontStyle appFontStyle) {
    return copyWith(
      fontWeight: appFontStyle.fontWeight,
      fontStyle: appFontStyle.fontStyle,
    );
  }

  /// Creates a copy of this TextStyle with a new color.
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  /// Creates a copy of this TextStyle with a new letter spacing.
  TextStyle withLetterSpacing(double letterSpacing) {
    return copyWith(letterSpacing: letterSpacing);
  }

  /// Creates a copy of this TextStyle with a new height (line height multiplier).
  TextStyle withHeight(double height) {
    return copyWith(height: height);
  }
}

extension AppFontStyleExtension on AppFontStyle {
  /// Returns the FontWeight corresponding to this AppFontStyle.
  FontWeight get fontWeight {
    switch (this) {
      case AppFontStyle.bold:
        return FontWeight.w700;
      case AppFontStyle.semiBold:
        return FontWeight.w600;
      case AppFontStyle.medium:
        return FontWeight.w500;
      case AppFontStyle.regular:
        return FontWeight.w400;
      case AppFontStyle.light:
        return FontWeight.w300;
    }
  }

  /// Returns the FontStyle corresponding to this AppFontStyle.
  /// Currently always returns normal. Override for italic support.
  FontStyle get fontStyle {
    return FontStyle.normal;
  }

  /// Applies this font style to a TextStyle.
  TextStyle apply(TextStyle style) {
    return style.copyWith(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  /// Creates a TextStyle directly from AppFontStyle.
  TextStyle toTextStyle({
    double? fontSize,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.poppins(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}