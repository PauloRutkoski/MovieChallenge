import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData getTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.grey[850],
        highlightColor: Colors.grey[500],
        primarySwatch: Colors.grey,
        cardColor: Colors.grey[800],
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.grey[700])),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey[300],
            fontSize: 16,
          ),
          headline3: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
