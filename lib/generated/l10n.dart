// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Available currencies`
  String get currency_list_title {
    return Intl.message(
      'Available currencies',
      name: 'currency_list_title',
      desc: '',
      args: [],
    );
  }

  /// `Currency detail`
  String get currency_detail_title {
    return Intl.message(
      'Currency detail',
      name: 'currency_detail_title',
      desc: '',
      args: [],
    );
  }

  /// `Loading, place wait`
  String get loading {
    return Intl.message(
      'Loading, place wait',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `{name} code`
  String code(Object name) {
    return Intl.message(
      '$name code',
      name: 'code',
      desc: '',
      args: [name],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `symbol`
  String get symbol {
    return Intl.message(
      'symbol',
      name: 'symbol',
      desc: '',
      args: [],
    );
  }

  /// `fraction`
  String get fraction {
    return Intl.message(
      'fraction',
      name: 'fraction',
      desc: '',
      args: [],
    );
  }

  /// `value is not string`
  String get not_a_string {
    return Intl.message(
      'value is not string',
      name: 'not_a_string',
      desc: '',
      args: [],
    );
  }

  /// `the string must not be empty`
  String get string_empty {
    return Intl.message(
      'the string must not be empty',
      name: 'string_empty',
      desc: '',
      args: [],
    );
  }

  /// `the value must not be empty`
  String get is_null {
    return Intl.message(
      'the value must not be empty',
      name: 'is_null',
      desc: '',
      args: [],
    );
  }

  /// `currency with this code is already in the database`
  String get currency_exist {
    return Intl.message(
      'currency with this code is already in the database',
      name: 'currency_exist',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error: `
  String get unknown_error {
    return Intl.message(
      'Unknown error: ',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `InvalidCommandException`
  String get invalid_command_exception {
    return Intl.message(
      'InvalidCommandException',
      name: 'invalid_command_exception',
      desc: '',
      args: [],
    );
  }

  /// `command not identified`
  String get command_not_identifier {
    return Intl.message(
      'command not identified',
      name: 'command_not_identifier',
      desc: '',
      args: [],
    );
  }

  /// `Invalid color value`
  String get invalid_color {
    return Intl.message(
      'Invalid color value',
      name: 'invalid_color',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}