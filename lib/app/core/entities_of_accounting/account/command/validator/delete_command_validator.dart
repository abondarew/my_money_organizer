import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/validator/container.dart';
import 'package:mymoneyorganizer/app/core/common/validator/list.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import '../delete_command.dart';
import 'account_can_be_delete_validator.dart';

class DeleteAccountCommandValidator extends BaseCommandValidator<AccountDeleteCommand> {
  final AccountBaseRepository repository;

  DeleteAccountCommandValidator(this.repository);

  @override
  Future<void> validate(AccountDeleteCommand command) async {
    ValidatorContainer containerValidator = new ValidatorContainer();
    ValidatorList notUse = ValidatorList([AccountCanBeDeleteValidator(repository: repository)]);
    containerValidator.add(notUse, command.id);
    // TODO: implement validate
    throw UnimplementedError();
  }
}
