import 'package:flutter/material.dart';

const textColor = Color(0xff263238);

ThemeData generateTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
    ),
    sliderTheme: const SliderThemeData(
      inactiveTrackColor: Colors.transparent,
      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 1.0),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
      activeTickMarkColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey), // Label text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'Rubik',
          letterSpacing: 0.5,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: textColor),

      // body
      bodyLarge: TextStyle(
        color: textColor,
        fontFamily: 'Rubik',
        letterSpacing: 0.04,
        height: 1.2,
        fontSize: 18,
      ),
      // regular
      bodyMedium: TextStyle(color: textColor, fontFamily: 'Rubik'),
      bodySmall: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelLarge: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displayLarge: TextStyle(color: textColor),
      headlineLarge: TextStyle(color: textColor),
      // title
      headlineMedium: TextStyle(
        color: textColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.04,
      ),
      headlineSmall: TextStyle(color: textColor),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll<TextStyle>(
          const TextStyle(
            fontFamily: 'Rubik',
            letterSpacing: 0.04,
            height: 1,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll<Color>(textColor),
      ),
    ),
  );
}
