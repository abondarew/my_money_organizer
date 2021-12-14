import 'package:flutter_translate/flutter_translate.dart';

String t(String key, {Map<String, dynamic>? args}) {
  return translate(key, args: args);
}

String tp(String key, num value, {Map<String, dynamic>? args}) {
  return translatePlural(key, value, args: args);
}
