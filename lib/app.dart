import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mymoneyorganizer/app/view/theme/app_theme_data_builder.dart';

import 'app/routes/routes.dart';
import 'app/view/screen/currency/currency_list_screen.dart';
import 'app/view/screen/dashboard/dashboard.dart';
//import 'package:mymoneyorganizer/generated/l10n.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalizedApp.of(context).delegate
      ],
      routes: {
        Routes.homePage: (context) => const DashBoard(),
        Routes.currencyList: (context) => CurrencyListScreen(),
      },
      supportedLocales: LocalizedApp.of(context).delegate.supportedLocales,
      theme: AppThemeBuilder.buildThemeData(context: context, brightness: Brightness.light),
      home: CurrencyListScreen(),
      //DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
