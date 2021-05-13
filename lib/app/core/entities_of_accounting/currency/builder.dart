import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/delete_command_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/service/currency_not_exist.dart';

import 'command/dispatcher/dispatcher.dart';
import 'command/handler/create_command_handler.dart';
import 'command/handler/delete_command_handler.dart';
import 'command/validator/create_command_validator.dart';
import 'query/dispatcher/query_dispatcher.dart';
import 'query/handler/fetch_currency_list.dart';
import 'query/handler/get_currency_from_id.dart';
import 'repository/base_repository.dart';

class CurrencyCoreBuilder {
  static CurrencyCommandDispatcher buildCommandDispatcher({@required CurrencyBaseRepository repository}) {
    final CurrencyCreateCommandHandler createCommandHandler = CurrencyCreateCommandHandler(
        validator: CurrencyCreateCommandValidator(serviceCurrencyNotExist: ServiceCurrencyIsExist(repository: repository)),
        repository: repository);
    final CurrencyDeleteCommandHandler deleteCommandHandler = CurrencyDeleteCommandHandler(repository: repository, validator: CurrencyDeleteCommandValidator());

    return CurrencyCommandDispatcher(createCommandHandler: createCommandHandler, deleteCommandHandler: deleteCommandHandler);
  }

  static CurrencyQueryDispatcher buildQueryDispatcher({@required CurrencyBaseRepository repository}) {
    final CurrencyQueryHandlerFetchList handlerFetchList = CurrencyQueryHandlerFetchList(repository: repository);
    final CurrencyQueryHandlerGetFromId handlerGetFromId = CurrencyQueryHandlerGetFromId(repository: repository);

    return CurrencyQueryDispatcher(handlerFetchList: handlerFetchList, handlerGetFromId: handlerGetFromId);
  }
}
