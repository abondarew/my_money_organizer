import 'package:flutter_translate/flutter_translate.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

String t(String key, {Map<String, dynamic>? args}) {
  return translate(key, args: args);
}

String tp(String key, num value, {Map<String, dynamic>? args}) {
  return translatePlural(key, value, args: args);
}
