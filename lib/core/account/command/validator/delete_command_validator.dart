import 'package:mymoneyorganizer/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/core/common/base/command/base_validator.dart';

class DeleteAccountCommandValidator extends BaseCommandValidator<AccountDeleteCommand> {
  @override
  Future<void> validate(AccountDeleteCommand command) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
