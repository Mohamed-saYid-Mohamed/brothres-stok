import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0D47A1); // Deep Blue
  static const Color primaryLight = Color(0xFF5472D3);
  static const Color primaryDark = Color(0xFF002171);

  // Secondary colors
  static const Color secondary = Color(0xFF263238); // Blue Grey
  static const Color secondaryLight = Color(0xFF4F5B62);
  static const Color secondaryDark = Color(0xFF000A12);

  // Accent colors
  static const Color accent = Color(
    0xFFFFC107,
  ); // Amber (for highlights/rating)

  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
}
