import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/open_close_account_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

class AccountCommandDispatcher {
  final BaseCommandHandler<AccountCreateCommand> createCommandHandler;
  final BaseCommandHandler<AccountDeleteCommand> deleteCommandHandler;
  final BaseCommandHandler<AccountUpdateSignOfActivity> updateSignOfActivityHandler;

  const AccountCommandDispatcher(
      {@required this.createCommandHandler,
      @required this.deleteCommandHandler,
      @required this.updateSignOfActivityHandler});
}
