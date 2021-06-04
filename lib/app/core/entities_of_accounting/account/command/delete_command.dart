import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

class AccountDeleteCommand extends BaseCommand {
  final String id;

  AccountDeleteCommand({required this.id});
}
