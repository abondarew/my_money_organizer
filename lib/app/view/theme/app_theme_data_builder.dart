import 'package:flutter/material.dart';

class AppThemeBuilder {
  static buildThemeData(BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal
          ),
        ),
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            brightness: Brightness.light,
            iconTheme: IconThemeData(
              color: Colors.black,
            )
        )
    );
  }
}