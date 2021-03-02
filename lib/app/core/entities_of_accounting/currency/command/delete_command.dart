import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

class CurrencyDeleteCommand extends BaseCommand{
  final String id;

  CurrencyDeleteCommand ({@required this.id});
}