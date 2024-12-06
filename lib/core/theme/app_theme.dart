import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stt_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        surfaceTintColor: AppColors.primary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.openSans(
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.all(4),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          backgroundColor: WidgetStateProperty.all(
            AppColors.primary,
          ),
          shadowColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
          overlayColor: WidgetStatePropertyAll(
            AppColors.background.withOpacity(0.25),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grayAccent,
        backgroundColor: AppColors.background,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      dialogBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        displayMedium: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        displaySmall: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        headlineMedium: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        headlineSmall: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        titleLarge: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        titleMedium: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        titleSmall: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        bodyLarge: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        bodyMedium: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        bodySmall: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        labelLarge: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
        labelMedium: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
