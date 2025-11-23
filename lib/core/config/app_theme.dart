import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xff093565);
  static const secondaryColor = Color(0xffF5F5F5);
  static const searchColor = Color.fromARGB(255, 3, 41, 82);
  static const secondryTextColor = Color(0xff63D9F3);

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: secondaryColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: primaryColor),
        bodyMedium: TextStyle(color: primaryColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: primaryColor,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: primaryColor,
        iconColor: secondryTextColor,
        textColor: secondaryColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: secondaryColor),
        bodyMedium: TextStyle(color: secondaryColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: primaryColor,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: secondaryColor,
        iconColor: secondryTextColor,
        textColor: primaryColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
      ),
    );
  }
}
