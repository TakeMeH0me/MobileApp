import 'package:flutter/material.dart';

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4A4E69),
  onPrimary: Colors.white,
  primaryContainer: Colors.black,
  onPrimaryContainer: Colors.white,
  secondary: Color(0xFF9A8C98),
  onSecondary: Colors.white,
  secondaryContainer: Colors.black,
  onSecondaryContainer: Color.fromARGB(255, 96, 62, 62),
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Colors.black,
  onErrorContainer: Colors.white,
  background: Color(0xFF222233),
  onBackground: Colors.white,
  surface: Color.fromARGB(255, 185, 185, 207),
  onSurface: Colors.white,
);

const ColorScheme lightColorScheme = ColorScheme(
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
  onSurface: Color.fromARGB(255, 29, 24, 24),
);
