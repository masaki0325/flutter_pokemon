import 'package:flutter/material.dart';

final customLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  textTheme: ThemeData.light().textTheme.copyWith(
        bodyLarge: const TextStyle(color: Colors.black),
      ),
);

final customDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  textTheme: ThemeData.dark().textTheme.copyWith(
        bodyLarge: const TextStyle(color: Colors.white),
      ),
);
