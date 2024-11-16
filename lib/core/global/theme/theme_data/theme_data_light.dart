import 'package:flutter/material.dart';

import '../app_color/app_color_light.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColorsLight.primaryColor,
  dialogBackgroundColor: AppColorsLight.backgroundColor,

  scaffoldBackgroundColor: AppColorsLight.backgroundColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColorsLight.textColor),
    bodyMedium: TextStyle(color: AppColorsLight.textColor),
  ),
  // Add more theme properties here
);
