import 'package:flutter/material.dart';

const black = Color(0xff191919);
const darkGrey = Color(0xff4C4C4C);
const textStepColor = Color(0xff999999);

const purple = Color(0xff7E57C2);
const purple2 = Color(0xff7F92D8);
const purple3 = Color(0xff7F92D8);

const blue = Color(0xff7FCCEE);
const blue2 = Color(0xff91D1F0);
const blue3 = Color(0xffB3DCF0);

const whiteGrey = Color(0xffE6E6E6);
const white = Color(0xffF5F5F5);

// TODO: change this to match the design
const breathStepIndicatorColor = Color(0xff92E3A9);
const correctAnswerColor = Color(0xffB8FFF2);
const wrongAnswerColor = Color(0xffFFD0D0);

ThemeData generateTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: purple,
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
        borderSide: BorderSide(color: purple, width: 2.0),
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
        foregroundColor: WidgetStatePropertyAll<Color>(black),
        side: WidgetStatePropertyAll<BorderSide>(
          const BorderSide(color: black),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: black),
      titleMedium: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: black),

      // body
      bodyLarge: TextStyle(
        color: black,
        fontFamily: 'Rubik',
        letterSpacing: 0.04,
        height: 1.2,
        fontSize: 18,
      ),
      // regular
      bodyMedium: TextStyle(
        color: black,
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.04,
      ),
      bodySmall: TextStyle(color: black),
      labelSmall: TextStyle(color: black),
      labelMedium: TextStyle(color: black),

      // step title
      labelLarge: TextStyle(
        color: Color(0xff999999),
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        fontSize: 18,
        height: 1.2,
      ),

      displaySmall: TextStyle(color: black),
      displayMedium: TextStyle(color: black),
      displayLarge: TextStyle(color: black),
      headlineLarge: TextStyle(
        color: black,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        height: 1.2,
      ),
      // title
      headlineMedium: TextStyle(
        color: black,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.04,
      ),
      headlineSmall: TextStyle(color: black),
    ),
  );
}
