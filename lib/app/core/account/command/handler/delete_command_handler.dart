import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/delete_command_validator.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

class AccountDeleteCommandHandler
    extends BaseCommandHandler<AccountDeleteCommand> {
  final AccountBaseRepository repository;
  final DeleteAccountCommandValidator validator;

  AccountDeleteCommandHandler(
      {@required this.repository, @required this.validator});

  @override
  Future<void> execute(AccountDeleteCommand deleteCommand) {
    this.validator.validate(deleteCommand);

    return this.repository.delete(deleteCommand);
  }

}