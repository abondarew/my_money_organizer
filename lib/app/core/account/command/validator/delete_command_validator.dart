import 'package:mymoneyorganizer/app/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/account_can_be_delete_validator.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/validator/container.dart';
import 'package:mymoneyorganizer/app/core/common/validator/list.dart';

class DeleteAccountCommandValidator extends BaseCommandValidator<AccountDeleteCommand> {
  final AccountBaseRepository repository;

  DeleteAccountCommandValidator(this.repository);

  @override
  Future<void> validate(AccountDeleteCommand command) {
    ContainerValidator containerValidator = new ContainerValidator();
    ListValidator notUse = ListValidator([AccountCanBeDeleteValidator(repository: repository)]);
    containerValidator.addValidator(notUse, command.id);
    // TODO: implement validate
    throw UnimplementedError();
  }
}
