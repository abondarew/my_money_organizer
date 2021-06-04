import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

class CurrencyDeleteCommand extends BaseCommand {
  final List<String> listId;

  CurrencyDeleteCommand({required this.listId});
}
