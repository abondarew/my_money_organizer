import 'package:flutter_translate/flutter_translate.dart';

class LocalizationDelegateContainer {
  static late final LocalizationDelegate _delegate;

  static Future<void> init() async {
    _delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: ['en'],
    );
  }

  static LocalizationDelegate get() => _delegate;
}
