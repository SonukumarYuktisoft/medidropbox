import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medidropbox/core/utility/const/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 255, 0, 0),
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      actionsPadding: EdgeInsets.all(8.0),
      toolbarHeight: 64.0,
      titleSpacing: 16.0,
      leadingWidth: 72.0,
      foregroundColor: Color(0xff212121),
      titleTextStyle: TextStyle(
        color: AppColors.scaffoldBackgroundColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        elevation: WidgetStatePropertyAll(8),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maximumSize: WidgetStatePropertyAll(Size.infinite),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),

    cardTheme: CardThemeData(elevation: 3, color: Colors.white),

    inputDecorationTheme: InputDecorationTheme(
      iconColor: const Color(0xFF03DAC6),
      activeIndicatorBorder: BorderSide(width: .5, color: Colors.grey),
      prefixIconColor: const Color(0xFF9CA3AF),
      suffixIconColor: const Color(0xFF9CA3AF),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: .5, color: Colors.grey),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.white,
      error: const Color(0xFFFF002F),
      onError: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static ThemeData darkThame = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff121212),
    dividerColor: Colors.white.withOpacity(.1),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 0, 238, 40),
    ),
    primaryColor: const Color.fromARGB(255, 1, 255, 192),
    secondaryHeaderColor: AppColors.secondaryColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 255, 0, 0),
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Color.fromARGB(255, 203, 3, 3),
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      actionsPadding: EdgeInsets.all(8.0),
      toolbarHeight: 64.0,
      titleSpacing: 16.0,
      leadingWidth: 72.0,
      foregroundColor: Color(0xff212121),
      titleTextStyle: TextStyle(
        color: AppColors.scaffoldBackgroundColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 3.0,
      color: Color(0xff212121),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff212121),
        foregroundColor: AppColors.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      activeIndicatorBorder: BorderSide(width: .5, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: .5, color: Colors.grey),
      ),
      labelStyle: TextStyle(fontSize: 14),
      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFF1E1E1E)),
        elevation: WidgetStatePropertyAll(8),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maximumSize: WidgetStatePropertyAll(Size.infinite),
      ),
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color.fromARGB(255, 2, 255, 166),
      onPrimary: Colors.white,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.white,
      error: const Color(0xFFFF002F),
      onError: Colors.black,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
  );
}
