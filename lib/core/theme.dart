import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3d5f90),
      surfaceTint: Color(0xff3d5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd5e3ff),
      onPrimaryContainer: Color(0xff234776),
      secondary: Color(0xff555f71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd9e3f8),
      onSecondaryContainer: Color(0xff3d4758),
      tertiary: Color(0xff6e5676),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff7d8ff),
      onTertiaryContainer: Color(0xff553f5d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa6c8ff),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001c3b),
      primaryFixedDim: Color(0xffa6c8ff),
      onPrimaryFixedVariant: Color(0xff234776),
      secondaryFixed: Color(0xffd9e3f8),
      onSecondaryFixed: Color(0xff121c2b),
      secondaryFixedDim: Color(0xffbdc7dc),
      onSecondaryFixedVariant: Color(0xff3d4758),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff27132f),
      tertiaryFixedDim: Color(0xffdabde2),
      onTertiaryFixedVariant: Color(0xff553f5d),
      surfaceDim: Color(0xffd9dae0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe1e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0c3665),
      surfaceTint: Color(0xff3d5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c6ea0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2d3747),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff636d80),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff442e4c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d6485),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0f1116),
      onSurfaceVariant: Color(0xff33363d),
      outline: Color(0xff4f525a),
      outlineVariant: Color(0xff6a6d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa6c8ff),
      primaryFixed: Color(0xff4c6ea0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff335686),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff636d80),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4b5567),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7d6485),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff644c6c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c6cd),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffe7e8ee),
      surfaceContainerHigh: Color(0xffdcdce3),
      surfaceContainerHighest: Color(0xffd0d1d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002c58),
      surfaceTint: Color(0xff3d5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff264a79),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff222d3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff404a5b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff392441),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff584160),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292c33),
      outlineVariant: Color(0xff464951),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa6c8ff),
      primaryFixed: Color(0xff264a79),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff063361),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff404a5b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff293343),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff584160),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff402b48),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7b8bf),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f7),
      surfaceContainer: Color(0xffe1e2e9),
      surfaceContainerHigh: Color(0xffd3d4da),
      surfaceContainerHighest: Color(0xffc5c6cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa6c8ff),
      surfaceTint: Color(0xffa6c8ff),
      onPrimary: Color(0xff02315f),
      primaryContainer: Color(0xff234776),
      onPrimaryContainer: Color(0xffd5e3ff),
      secondary: Color(0xffbdc7dc),
      onSecondary: Color(0xff273141),
      secondaryContainer: Color(0xff3d4758),
      onSecondaryContainer: Color(0xffd9e3f8),
      tertiary: Color(0xffdabde2),
      onTertiary: Color(0xff3d2846),
      tertiaryContainer: Color(0xff553f5d),
      onTertiaryContainer: Color(0xfff7d8ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe1e2e9),
      onSurfaceVariant: Color(0xffc4c6cf),
      outline: Color(0xff8d9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff3d5f90),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001c3b),
      primaryFixedDim: Color(0xffa6c8ff),
      onPrimaryFixedVariant: Color(0xff234776),
      secondaryFixed: Color(0xffd9e3f8),
      onSecondaryFixed: Color(0xff121c2b),
      secondaryFixedDim: Color(0xffbdc7dc),
      onSecondaryFixedVariant: Color(0xff3d4758),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff27132f),
      tertiaryFixedDim: Color(0xffdabde2),
      onTertiaryFixedVariant: Color(0xff553f5d),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff32353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbddff),
      surfaceTint: Color(0xffa6c8ff),
      onPrimary: Color(0xff00264d),
      primaryContainer: Color(0xff7192c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd2ddf2),
      onSecondary: Color(0xff1c2636),
      secondaryContainer: Color(0xff8791a5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff1d2f8),
      onTertiary: Color(0xff321e3a),
      tertiaryContainer: Color(0xffa388aa),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce5),
      outline: Color(0xffafb2bb),
      outlineVariant: Color(0xff8d9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff244978),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001129),
      primaryFixedDim: Color(0xffa6c8ff),
      onPrimaryFixedVariant: Color(0xff0c3665),
      secondaryFixed: Color(0xffd9e3f8),
      onSecondaryFixed: Color(0xff071120),
      secondaryFixedDim: Color(0xffbdc7dc),
      onSecondaryFixedVariant: Color(0xff2d3747),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff1c0924),
      tertiaryFixedDim: Color(0xffdabde2),
      onTertiaryFixedVariant: Color(0xff442e4c),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff42444a),
      surfaceContainerLowest: Color(0xff05070c),
      surfaceContainerLow: Color(0xff1b1e22),
      surfaceContainer: Color(0xff26282d),
      surfaceContainerHigh: Color(0xff303338),
      surfaceContainerHighest: Color(0xff3b3e43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeaf0ff),
      surfaceTint: Color(0xffa6c8ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa2c4fb),
      onPrimaryContainer: Color(0xff000b1e),
      secondary: Color(0xffeaf0ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb9c3d8),
      onSecondaryContainer: Color(0xff030b1a),
      tertiary: Color(0xfffdeaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd6b9de),
      onTertiaryContainer: Color(0xff15041e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf0f9),
      outlineVariant: Color(0xffc0c2cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff244978),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa6c8ff),
      onPrimaryFixedVariant: Color(0xff001129),
      secondaryFixed: Color(0xffd9e3f8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbdc7dc),
      onSecondaryFixedVariant: Color(0xff071120),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffdabde2),
      onTertiaryFixedVariant: Color(0xff1c0924),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff4e5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2024),
      surfaceContainer: Color(0xff2e3035),
      surfaceContainerHigh: Color(0xff393b41),
      surfaceContainerHighest: Color(0xff45474c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,

        // elements
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              colorScheme.secondaryContainer,
            ),
            foregroundColor: WidgetStateProperty.all(
              colorScheme.onSecondaryContainer,
            ),
            textStyle: WidgetStateProperty.all(
              textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              colorScheme.surface,
            ),
            foregroundColor: WidgetStateProperty.all(
              colorScheme.onSurface,
            ),
            textStyle: WidgetStateProperty.all(
              textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              colorScheme.primary,
            ),
            foregroundColor: WidgetStateProperty.all(
              colorScheme.onPrimary,
            ),
            textStyle: WidgetStateProperty.all(
              textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 3,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          color: colorScheme.surface.withAlpha(200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: colorScheme.outline,
            ),
          ),
          counterStyle: textTheme.labelMedium?.copyWith(
            fontSize: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: colorScheme.error,
            ),
          ),
          labelStyle: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          hintStyle: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          errorStyle: textTheme.labelMedium?.copyWith(
            color: colorScheme.onError,
          ),
        ),
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
