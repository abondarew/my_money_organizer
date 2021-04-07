// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(name) => "${name} code";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "code" : m0,
    "command_not_identifier" : MessageLookupByLibrary.simpleMessage("command not identified"),
    "currency" : MessageLookupByLibrary.simpleMessage("Currency"),
    "currency_detail_title" : MessageLookupByLibrary.simpleMessage("Currency detail"),
    "currency_exist" : MessageLookupByLibrary.simpleMessage("currency with this code is already in the database"),
    "currency_list_title" : MessageLookupByLibrary.simpleMessage("Available currencies"),
    "fraction" : MessageLookupByLibrary.simpleMessage("fraction"),
    "invalid_command_exception" : MessageLookupByLibrary.simpleMessage("InvalidCommandException"),
    "is_null" : MessageLookupByLibrary.simpleMessage("the value must not be empty"),
    "loading" : MessageLookupByLibrary.simpleMessage("Loading, place wait"),
    "name" : MessageLookupByLibrary.simpleMessage("name"),
    "not_a_string" : MessageLookupByLibrary.simpleMessage("value is not string"),
    "string_empty" : MessageLookupByLibrary.simpleMessage("the string must not be empty"),
    "symbol" : MessageLookupByLibrary.simpleMessage("symbol"),
    "unknown_error" : MessageLookupByLibrary.simpleMessage("Unknown error: ")
  };
}
