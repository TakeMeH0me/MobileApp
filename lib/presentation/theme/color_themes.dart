import 'package:flutter/material.dart';

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4A4E69), // Primary color
  onPrimary: Colors.white,
  primaryContainer: Colors.black,
  onPrimaryContainer: Colors.white,
  secondary: Color(0xFF9A8C98), // Secondary color
  onSecondary: Colors.white,
  secondaryContainer: Colors.black,
  onSecondaryContainer: const Color.fromARGB(255, 96, 62, 62),
  error: Colors.red, // Error color
  onError: Colors.white,
  errorContainer: Colors.black,
  onErrorContainer: Colors.white,
  background: Color(0xFF222233), // Darker background color
  onBackground: Colors.white,
  surface: Color.fromARGB(255, 185, 185, 207), // Surface color
  onSurface: Colors.white,
);

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 247, 246, 246),
  onPrimary: Color.fromARGB(255, 29, 26, 26),
  primaryContainer: Color.fromARGB(255, 124, 76, 76),
  onPrimaryContainer: Colors.black,
  secondary: Color.fromARGB(255, 182, 182, 219),
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFF9A8C98),
  onSecondaryContainer: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Color(0xFFF2E9E4),
  onBackground: Colors.black,
  surface: Color.fromARGB(255, 167, 144, 164),
  onSurface: const Color.fromARGB(255, 29, 24, 24),
);
