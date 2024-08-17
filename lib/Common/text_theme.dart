import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme myTextTheme = TextTheme(
  // Large
  displayLarge: GoogleFonts.merriweatherSans(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headlineLarge: GoogleFonts.merriweatherSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  titleLarge: GoogleFonts.merriweatherSans(
      fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  bodyLarge: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  labelLarge: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),

  // Medium
  displayMedium: GoogleFonts.merriweatherSans(
      fontSize: 45, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headlineMedium: GoogleFonts.merriweatherSans(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  titleMedium: GoogleFonts.merriweatherSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  bodyMedium: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelMedium: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1.25),

  // Small
  displaySmall:
      GoogleFonts.merriweatherSans(fontSize: 36, fontWeight: FontWeight.w400),
  headlineSmall:
      GoogleFonts.merriweatherSans(fontSize: 24, fontWeight: FontWeight.w400),
  titleSmall: GoogleFonts.merriweatherSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodySmall: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.libreFranklin(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
