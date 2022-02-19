import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeBuilder {
  static buildThemeData({required BuildContext context, Brightness brightness = Brightness.light}) {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
      brightness: brightness,
      cardTheme: CardTheme(
        shadowColor: brightness == Brightness.light ? Colors.grey.shade400 : Colors.black54,
      ),
      /*primaryTextTheme: const TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal),
      ),*/
      //canvasColor: Colors.white,
      /*appBarTheme: const AppBarTheme(
        color: Colors.black54,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),*/
      appBarTheme: AppBarTheme(
        elevation: 8,
        shadowColor: brightness == Brightness.light ? Colors.grey.shade700 : Colors.black54,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade900,
    );
  }
}
