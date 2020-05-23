import 'package:flutter/material.dart';

final themeData = _themeData();

final Color background = Color(0xFFFFFFFF);
final Color canvas = Color(0xFFF7F7FA);
final Color primary = Color(0xFF6200EE);
final Color primaryVariant = Color(0xFF3700B3);
final Color secondary = Color(0xFFBB86FC);

ThemeData _themeData() {
  final base = ThemeData.light();
  return base.copyWith(
    accentColor: primary,
    scaffoldBackgroundColor: background,
    canvasColor: canvas,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: secondary,
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 1.5,
      overlayColor: secondary.withOpacity(0.24),
      activeTrackColor: primaryVariant,
      inactiveTrackColor: Colors.grey[300],
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
      thumbColor: primary,
    ),
  );
}
