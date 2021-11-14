import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData getTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        highlightColor: Colors.grey[500],
        primarySwatch: Colors.grey,
        cardColor: Colors.grey[850],
        iconTheme: IconThemeData(
          color: Colors.grey[300],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.grey[700])),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey[300],
            fontSize: 16,
          ),
          headline1: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          headline3: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
