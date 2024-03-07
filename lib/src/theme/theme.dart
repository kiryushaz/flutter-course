import 'package:flutter/material.dart';

final coffeeAppTheme = ThemeData(
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF85C3DE),
    background: const Color(0xFFF7FAF8),
    surface: const Color(0xFFF7FAF8),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12)
  ),
  useMaterial3: true
);
