import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/validator/update_command_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import '../update_command.dart';

class AccountUpdateCommandHandler extends BaseCommandHandler<UpdateAccountCommand> {
  final AccountBaseRepository repository;
  final UpdateAccountCommandValidator validator;

  AccountUpdateCommandHandler({required this.repository, required this.validator});

  @override
  Future<void> execute(UpdateAccountCommand command) async {
    validator.validate(command);

    // TODO: implement execute
    throw UnimplementedError();
  }
}
