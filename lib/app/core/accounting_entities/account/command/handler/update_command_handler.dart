import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/account/command/validator/update_command_validator.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

import '../update_command.dart';

class AccountUpdateCommandHandler extends BaseCommandHandler<UpdateAccountCommand>{
  final AccountBaseRepository repository;
  final UpdateAccountCommandValidator validator;

  AccountUpdateCommandHandler({@required this.repository, @required this.validator});

  @override
  Future<void> execute(UpdateAccountCommand command) {
    validator.validate(command);

    // TODO: implement execute
    throw UnimplementedError();
  }

}