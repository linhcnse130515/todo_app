import 'package:flutter/material.dart';

class MyTheme {
  ThemeData buildTheme() {
    return ThemeData(
        accentColor: Color.fromRGBO(255, 140, 0, 1.0),
        primaryColor: Colors.red,
        buttonColor: Color.fromRGBO(0, 122, 255, 1.0),
        disabledColor: Color.fromRGBO(142, 142, 147, 1.2),
        primaryColorLight: Color.fromRGBO(163, 179, 211, 1),
        secondaryHeaderColor: Color.fromRGBO(135, 158, 215, 10),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:
            AppBarTheme(iconTheme: IconThemeData(color: Colors.black)));
  }
}
