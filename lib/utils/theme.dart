import 'package:flutter/material.dart';

const Color primary = Color(0xFF46422E);
const Color secondary = Color(0xFFF1EAB9);
const Color tertiary = Colors.black;
const Color white = Color(0xFFF9F6ED);

const Color second2 = Color.fromARGB(255, 58, 54, 43);
const Color greenCustom = Color(0xFF57B35F);

Color errorColor = Colors.red.shade300;

const double largeSize = 20;
const double mediumSize = 16;
const double smallSize = 12;

//ThemeData
//
ThemeData theme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: largeSize, color: tertiary, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
        fontSize: mediumSize, color: tertiary, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        fontSize: smallSize, color: tertiary, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        fontWeight: FontWeight.normal, fontSize: largeSize, color: tertiary),
    labelMedium: TextStyle(
        fontWeight: FontWeight.normal, fontSize: mediumSize, color: tertiary),
    labelSmall: TextStyle(
        fontWeight: FontWeight.normal, fontSize: smallSize, color: tertiary),
  ),

  //SnackBarTheme
  //
  snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),

  //ScrollbarTheme
  //
  scrollbarTheme: const ScrollbarThemeData(
    trackVisibility: WidgetStatePropertyAll(true),
    interactive: true,
    thickness: WidgetStatePropertyAll(8),
    thumbVisibility: WidgetStatePropertyAll(true),
  ),

  //ColorScheme
  //
  colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      error: Colors.red.shade300),

  useMaterial3: true,
);

//ThemeData
//
ThemeData themeDark = ThemeData.dark().copyWith(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: largeSize, color: white),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: mediumSize, color: white),
      bodySmall: TextStyle(
          fontWeight: FontWeight.bold, fontSize: smallSize, color: white),
      labelLarge: TextStyle(
          fontWeight: FontWeight.normal, fontSize: largeSize, color: white),
      labelMedium: TextStyle(
          fontWeight: FontWeight.normal, fontSize: mediumSize, color: white),
      labelSmall: TextStyle(
          fontWeight: FontWeight.normal, fontSize: smallSize, color: white),
    ),
    //SnackBarTheme
    //
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),

    //ScrollbarTheme
    //
    scrollbarTheme: const ScrollbarThemeData(
      trackVisibility: WidgetStatePropertyAll(true),
      interactive: true,
      thickness: WidgetStatePropertyAll(8),
      thumbVisibility: WidgetStatePropertyAll(true),
    ),

    //Color Scheme
    //
    colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
        primary: primary,
        secondary: secondary,
        tertiary: const Color(0xFF57B35F)));
