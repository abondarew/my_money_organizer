import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/validator/container.dart';
import 'package:mymoneyorganizer/app/core/common/validator/list.dart';
import 'package:mymoneyorganizer/app/core/common/validator/not_null.dart';
import 'package:mymoneyorganizer/app/core/common/validator/string_not_empty.dart';

import '../create_command.dart';
import 'exception/create_command_exception.dart';

class CreateAccountCommandValidator extends BaseCommandValidator<AccountCreateCommand> {
  @override
  Future<void> validate(AccountCreateCommand command) async {
    ContainerValidator containerValidator = ContainerValidator();

    ListValidator name = ListValidator([StringNotEmptyValidator()]);
    ListValidator type = ListValidator([StringNotEmptyValidator()]);
    ListValidator isActive = ListValidator([ValueNotNullValidator()]);
    ListValidator isSaving = ListValidator([ValueNotNullValidator()]);
    ListValidator currency = ListValidator([ValueNotNullValidator()]);

    containerValidator
      ..addValidator(name, command.name)
      ..addValidator(type, command.type)
      ..addValidator(isActive, command.isActive)
      ..addValidator(isSaving, command.isSavingAccount)
      ..addValidator(currency, command.currency);

    if (!(await containerValidator.isValid())) {
      throw new AccountCreateException(
          name: name.getErrors(),
          type: type.getErrors(),
          activeFlag: isActive.getErrors(),
          savingFlag: isSaving.getErrors(),
          currency: currency.getErrors());
    }
  }
}
