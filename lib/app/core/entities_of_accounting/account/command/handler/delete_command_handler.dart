import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/validator/delete_command_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import '../delete_command.dart';

class AccountDeleteCommandHandler extends BaseCommandHandler<AccountDeleteCommand> {
  final AccountBaseRepository repository;
  final DeleteAccountCommandValidator validator;

  AccountDeleteCommandHandler({required this.repository, required this.validator});

  @override
  Future<void> execute(AccountDeleteCommand deleteCommand) async {
    this.validator.validate(deleteCommand);

    return this.repository.delete(deleteCommand);
  }
}
