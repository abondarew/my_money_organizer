import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';

class AccountCreateHandler extends BaseCommandHandler<AccountCreateCommand> {
  final AccountBaseRepository repository;
  final BaseCommandValidator<AccountCreateCommand> validator;

  AccountCreateHandler({@required this.repository, @required this.validator});

  @override
  Future<void> execute(AccountCreateCommand command) async {
    this.validator.validate(command);

    AccountDomainModel account = AccountDomainModel(
        accountTypeId: command.type,
        accountName: command.name,
        isActive: command.isActive,
        isSavingAccount: command.isSavingAccount,
        accountCurrency: command.currency,
        accountBalance: command.balance,
        icoUri: command.icoUri);
    repository.save(account);
  }
}
