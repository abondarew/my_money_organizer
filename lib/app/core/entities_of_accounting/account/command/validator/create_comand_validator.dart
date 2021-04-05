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
    ValidatorContainer containerValidator = ValidatorContainer();

    ValidatorList name = ValidatorList([StringNotEmptyValidator()]);
    ValidatorList type = ValidatorList([StringNotEmptyValidator()]);
    ValidatorList isActive = ValidatorList([ValueNotNullValidator()]);
    ValidatorList isSaving = ValidatorList([ValueNotNullValidator()]);
    ValidatorList currency = ValidatorList([ValueNotNullValidator()]);

    containerValidator
      ..add(name, command.name)
      ..add(type, command.type)
      ..add(isActive, command.isActive)
      ..add(isSaving, command.isSavingAccount)
      ..add(currency, command.currency);

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
