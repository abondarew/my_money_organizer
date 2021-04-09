import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

class CurrencyCreateCommand extends BaseCommand {
  final String id;
  final bool isNew;
  final String name;
  final String symbol;
  final int fraction;
  final int avatarColor;

  CurrencyCreateCommand(
      {@required this.id, @required this.isNew, @required this.name, @required this.symbol, @required this.fraction, @required this.avatarColor});
}
