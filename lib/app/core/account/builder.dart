import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/handler/create_comand_handler.dart';
import 'package:mymoneyorganizer/app/core/account/command/handler/delete_command_handler.dart';
import 'package:mymoneyorganizer/app/core/account/command/handler/update_command_handler.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/create_comand_validator.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/delete_command_validator.dart';
import 'package:mymoneyorganizer/app/core/account/command/validator/update_command_validator.dart';
import 'package:mymoneyorganizer/app/core/account/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/account/query/handler/account_query_handler.dart';
import 'package:mymoneyorganizer/app/core/account/query/handler/list_query_handler.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';

import 'command/dispather/command_dispather.dart';

class AccountCoreBuilder {
  static AccountCommandDispatcher buildCommandDispatcher({@required AccountBaseRepository repository}) {
    final AccountCreateCommandHandler createCommandHandler =
        AccountCreateCommandHandler(repository: repository, validator: CreateAccountCommandValidator());
    final AccountDeleteCommandHandler deleteCommandHandler =
        AccountDeleteCommandHandler(repository: repository, validator: DeleteAccountCommandValidator(repository));
    final AccountUpdateCommandHandler updateCommandHandler = AccountUpdateCommandHandler(repository: repository, validator: UpdateAccountCommandValidator());

    return AccountCommandDispatcher(
        createCommandHandler: createCommandHandler,
        deleteCommandHandler: deleteCommandHandler,
        updateCommandHandler: updateCommandHandler);
  }

  static AccountQueryDispatcher buildQueryDispatcher({@required AccountBaseRepository repository}) {
    final FetchAccountQueryHandler accountQueryHandler = FetchAccountQueryHandler(repository: repository);
    final FetchAccountListQueryHandler listQueryHandler = FetchAccountListQueryHandler(repository: repository);

    return AccountQueryDispatcher(accountQueryHandler: accountQueryHandler, listQueryHandler: listQueryHandler);
  }
}
