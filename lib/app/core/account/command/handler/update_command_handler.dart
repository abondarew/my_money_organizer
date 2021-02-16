import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/update_command.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

class AccountUpdateCommandHandler extends BaseCommandHandler<UpdateAccountCommand>{
  final AccountBaseRepository repository;

  AccountUpdateCommandHandler({@required this.repository});

  @override
  Future<void> execute(UpdateAccountCommand command) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}