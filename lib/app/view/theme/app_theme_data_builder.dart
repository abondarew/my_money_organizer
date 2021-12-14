import 'package:flutter/material.dart';

class AppThemeBuilder {
  static buildThemeData(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.indigo,
      primaryTextTheme: const TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal),
      ),
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        //brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey.shade300,
    );
  }
}
