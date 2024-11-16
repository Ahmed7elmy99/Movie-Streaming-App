import 'package:flutter/material.dart';

import '../app_color/app_color_dark.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColorsDark.primaryColor,
  dialogBackgroundColor: AppColorsDark.backgroundColor,
  scaffoldBackgroundColor: AppColorsDark.backgroundColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColorsDark.textColor),
    bodyMedium: TextStyle(color: AppColorsDark.textColor),
  ),
  // Add more theme properties here
);
