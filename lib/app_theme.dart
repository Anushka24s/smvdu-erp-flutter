import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void toggleAppTheme() {
  themeNotifier.value =
      themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder:
            (_, mode, __) => Icon(
              mode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: Colors.white70,
            ),
      ),
      onPressed: toggleAppTheme,
    );
  }
}

ThemeData buildLightTheme() {
  const primary = Color(0xFF0A2540);
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      surface: Colors.white,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF0F4F8),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFFAFAFD)),
  );
}

ThemeData buildDarkTheme() {
  const primary = Color(0xFF6BB6FF);
  const surface = Color(0xFF161B22);
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
      primary: primary,
      surface: surface,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D1117),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A1624),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF161B22)),
    dividerTheme: const DividerThemeData(color: Color(0xFF30363D)),
  );
}
