import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

class AccountCreateCommandHandler extends BaseCommandHandler<AccountCreateCommand> {
  final AccountBaseRepository repository;
  final BaseCommandValidator<AccountCreateCommand> validator;

  AccountCreateCommandHandler({required this.repository, required this.validator});

  @override
  Future<void> execute(AccountCreateCommand command) async {
    this.validator.validate(command);

    AccountDomainModel account = AccountDomainModel(
        accountTypeId: command.type,
        accountName: command.name,
        isActive: command.isActive,
        isSavingAccount: command.isSavingAccount,
        accountCurrencyId: command.currency,
        accountBalance: command.balance,
        icoUri: command.icoUri);
    repository.save(account);
  }
}
