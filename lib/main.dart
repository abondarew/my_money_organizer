import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app.dart';
import 'package:mymoneyorganizer/environment.dart';

void main() {
  Environment.init(debug: false, dataBaseType: DataBaseType.MEMORY);
  runApp(MainApp());
}
