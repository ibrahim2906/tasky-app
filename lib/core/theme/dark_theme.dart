import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0XFF1A1A1A),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0XFF1A1A1A),
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Colors.white,
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
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayMedium: TextStyle(fontSize: 28, color: Colors.white),
    displaySmall: TextStyle(fontSize: 24, color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white54),
    filled: true,
    fillColor: Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.black, width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white,
    iconColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  dividerTheme: DividerThemeData(color: Colors.white54),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionHandleColor: Colors.green,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(color: Colors.black),

);
