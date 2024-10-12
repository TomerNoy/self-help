import 'package:flutter/material.dart';

const pastelBlue = Color(0xffAEC6CF);
const mintGreen = Color(0xffC8E6C9);
const lightPink = Color(0xffF8BBD0);
const whiteSmoke = Color(0xffF5F5F5);
const lavender = Color(0xffE6E6FA);
const textColor = Color(0xff474747);

ThemeData generateTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: pastelBlue,
      secondary: mintGreen,
      surface: whiteSmoke,
    ),
    sliderTheme: const SliderThemeData(
      inactiveTrackColor: Colors.transparent,
      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 1.0),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
      activeTickMarkColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor),
      titleSmall: TextStyle(color: textColor),
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelLarge: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displayLarge: TextStyle(color: textColor),
      headlineLarge: TextStyle(color: textColor),
      headlineMedium: TextStyle(color: textColor),
      headlineSmall: TextStyle(color: textColor),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll<Color>(textColor),
      ),
    ),
  );
}
