import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_list_screen.dart';
import 'package:mymoneyorganizer/app/view/theme/app_theme_data_builder.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: AppThemeBuilder.buildThemeData(context),
      home: CurrencyListScreen(),
    );
  }

}