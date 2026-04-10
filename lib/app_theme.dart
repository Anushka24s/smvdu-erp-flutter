import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void toggleAppTheme() {
  themeNotifier.value =
      themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF0A2540),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF0F4F8),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF1565C0),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D1117),
  );
}
