import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/update_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/update_command_validator.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

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