import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/builder.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/dispatcher/dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/infrastructure/container/database_connection_container.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/currency_repository.dart';

class CurrencyCoreContainer {
  static CurrencyCoreContainer? _instance;
  final CurrencyQueryDispatcher queryDispatcher;
  final CurrencyCommandDispatcher commandDispatcher;

  CurrencyCoreContainer._({required this.queryDispatcher, required this.commandDispatcher});

  factory CurrencyCoreContainer.getInstance() {
    if (_instance == null) {
      CurrencyBaseRepository repository = CurrencyDatabaseRepository(DatabaseConnectionContainer.getConnection());
      _instance = CurrencyCoreContainer._(
          queryDispatcher: CurrencyCoreBuilder.buildQueryDispatcher(repository: repository),
          commandDispatcher: CurrencyCoreBuilder.buildCommandDispatcher(repository: repository));
    }
    return _instance!;
  }
}
