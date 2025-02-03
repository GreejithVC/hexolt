import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.bgColor,
  appBarTheme: AppBarTheme(
    color: AppColors.primaryColor,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.buttonTextColor,
    ),
    iconTheme: const IconThemeData(color: AppColors.buttonTextColor),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textBlackColor,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textBlackColor,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.textBlackColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textBlackColor,
    ),
  ),
);
