import 'package:flutter/material.dart';

import 'app_colors.dart';

final coffeeAppTheme = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: CoffeeAppColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CoffeeAppColors.primary,
    background: CoffeeAppColors.screenBackground,
    surface: CoffeeAppColors.screenBackground,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)
  ),
  useMaterial3: true
);
