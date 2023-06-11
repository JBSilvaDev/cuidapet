import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'Cuidapet';
  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffb4d456),
        primaryColorDark: const Color(0xff689f38),
        primaryColorLight: const Color(0xffdde9cf),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffb4d456),
        ),
      );
}
