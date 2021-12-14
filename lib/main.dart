import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mymoneyorganizer/app.dart';
import 'package:mymoneyorganizer/app/lib/localization/delegate_container.dart';
import 'package:mymoneyorganizer/environment.dart';

void main() async {
  Environment.init(debug: false, dataBaseType: DataBaseType.MEMORY);
  await LocalizationDelegateContainer.init();
  runApp(LocalizedApp(LocalizationDelegateContainer.get(), const MainApp()));
}
