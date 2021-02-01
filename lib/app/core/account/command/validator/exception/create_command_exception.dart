import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';

class AccountCreateException extends BaseCommandException {
  final List<String> name;
  final List<String> type;
  final List<String> activeFlag;
  final List<String> savingFlag;
  final List<String> currency;
  final String message;

  AccountCreateException(
      {@required this.name,
      @required this.type,
      @required this.activeFlag,
      @required this.savingFlag,
      @required this.currency,
      this.message});
}
