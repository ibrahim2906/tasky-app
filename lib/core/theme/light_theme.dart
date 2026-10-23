import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFDBDCDC),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFDBDCDC),
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFD1DaD6),
    secondary: Colors.black,
    surface: Color(0xFFD5D5D5)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.deepPurple;
      }
      return null;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.deepPurple.withOpacity(0.54);
      }
      return null;
    }),
  ),
  useMaterial3: true,
  brightness: Brightness.light,

  textTheme: const TextTheme(
    displayMedium: TextStyle(fontSize: 28, color: Colors.black),
    displaySmall: TextStyle(fontSize: 24, color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),

    //for only done tasks
    titleSmall: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.black26),
    filled: true,
    fillColor: Colors.white70,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.black),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Colors.black),
  listTileTheme: ListTileThemeData(
    textColor: Colors.black,
    iconColor: Colors.black,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  dividerTheme: DividerThemeData(color: Colors.black26),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.green,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(color: Colors.white70),
);
