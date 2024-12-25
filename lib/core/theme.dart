import 'package:flutter/material.dart';

const textTitleColor = Color(0xff191919);
const textSubtitleColor = Color(0xff4C4C4C);
const textAboveAnimationColor = Color(0xff263238);
const textStepColor = Color(0xff999999);

const gradientStartColor = Color(0xff79C3DD);
const gradientEndColor = Color(0xff6E79ED);

const breathStepIndicatorColor = Color(0xff92E3A9);

const greyBackgroundColor = Color(0xffE6E6E6);

const buttonBackgroundBlack = Color(0xff1A1A1A);

const correctAnswerColor = Color(0xffB8FFF2);
const wrongAnswerColor = Color(0xffFFD0D0);

ThemeData generateTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: gradientEndColor,
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
        foregroundColor: WidgetStatePropertyAll<Color>(textTitleColor),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textTitleColor),
      titleMedium: TextStyle(
        color: textTitleColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: textTitleColor),

      // body
      bodyLarge: TextStyle(
        color: textTitleColor,
        fontFamily: 'Rubik',
        letterSpacing: 0.04,
        height: 1.2,
        fontSize: 18,
      ),
      // regular
      bodyMedium: TextStyle(
        color: textTitleColor,
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.04,
      ),
      bodySmall: TextStyle(color: textTitleColor),
      labelSmall: TextStyle(color: textTitleColor),
      labelMedium: TextStyle(color: textTitleColor),

      // step title
      labelLarge: TextStyle(
        color: Color(0xff999999),
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        fontSize: 18,
        height: 1.2,
      ),

      displaySmall: TextStyle(color: textTitleColor),
      displayMedium: TextStyle(color: textTitleColor),
      displayLarge: TextStyle(color: textTitleColor),
      headlineLarge: TextStyle(
        color: textTitleColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.04,
        height: 1.2,
      ),
      // title
      headlineMedium: TextStyle(
        color: textTitleColor,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.04,
      ),
      headlineSmall: TextStyle(color: textTitleColor),
    ),
  );
}
