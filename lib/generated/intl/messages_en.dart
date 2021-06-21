// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "${name} code";

  static String m1(what, records) =>
      "You are sure you want to delete ${what} ${records}?";

  static String m2(what, records, quantity) =>
      "You are sure you want to delete ${what} ${records} (and ${quantity} more) records?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "choice_color": MessageLookupByLibrary.simpleMessage("choice color"),
        "code": m0,
        "command_not_identifier":
            MessageLookupByLibrary.simpleMessage("command not identified"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_text": m1,
        "confirm_text_more": m2,
        "currency": MessageLookupByLibrary.simpleMessage("Currency"),
        "currency_detail_title":
            MessageLookupByLibrary.simpleMessage("Currency detail"),
        "currency_exist": MessageLookupByLibrary.simpleMessage(
            "currency with this code is already in the database"),
        "currency_list_title":
            MessageLookupByLibrary.simpleMessage("Available currencies"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "fraction": MessageLookupByLibrary.simpleMessage("fraction"),
        "invalid_color":
            MessageLookupByLibrary.simpleMessage("Invalid color value"),
        "invalid_command_exception":
            MessageLookupByLibrary.simpleMessage("InvalidCommandException"),
        "is_null":
            MessageLookupByLibrary.simpleMessage("the value must not be empty"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading, place wait"),
        "name": MessageLookupByLibrary.simpleMessage("name"),
        "not_a_string":
            MessageLookupByLibrary.simpleMessage("value is not string"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "setAsDefault": MessageLookupByLibrary.simpleMessage("Set as default"),
        "string_empty": MessageLookupByLibrary.simpleMessage(
            "the string must not be empty"),
        "symbol": MessageLookupByLibrary.simpleMessage("symbol"),
        "unknown_error": MessageLookupByLibrary.simpleMessage("Unknown error: ")
      };
}
