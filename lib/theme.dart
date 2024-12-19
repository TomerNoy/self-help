import 'package:flutter/material.dart';

const textColor = Color(0xff4C4C4C);

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
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
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
          borderRadius: BorderRadius.circular(26),
        ),
        padding: const EdgeInsets.all(0),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'Rubik',
          letterSpacing: 0.04,
          height: 1,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll<TextStyle>(
          const TextStyle(
            fontFamily: 'Rubik',
            height: 1,
            letterSpacing: 0.04,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll<Color>(textColor),
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
      bodyMedium: TextStyle(
        color: textColor,
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.04,
      ),
      bodySmall: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),

      // step title
      labelLarge: TextStyle(
        color: Color(0xff999999),
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        fontSize: 18,
        height: 1.2,
      ),

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
  );
}
