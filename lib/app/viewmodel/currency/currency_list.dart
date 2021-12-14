import 'dart:async';

import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/dispatcher/dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/fetch_currency_list.dart';
import 'package:mymoneyorganizer/app/infrastructure/container/currency_core_container.dart';

class CurrencyListViewModel {
  final CurrencyQueryDispatcher _queryDispatcher;
  final CurrencyCommandDispatcher _commandDispatcher;

  final StreamController<CurrencyListNotification> _eventController = StreamController.broadcast();

  Stream<CurrencyListNotification> get event {
    return _eventController.stream;
  }

  CurrencyListViewModel(this._queryDispatcher, this._commandDispatcher);

  Future<void> load() async {
    List<CurrencyListReadModel>? result = await _queryDispatcher.dispatch(CurrencyQueryFetchList());
    _eventController.add(ResultCurrencyListNotification(result));
  }

  void delete(List<String> currencyIdList) async {
    await _commandDispatcher.dispatch(CurrencyDeleteCommand(listId: currencyIdList));
  }

  void setAsDefault(String id) async {}

  void dispose() {
    _eventController.close();
  }
}

class CurrencyListViewModelBuilder {
  static CurrencyListViewModel build() {
    return CurrencyListViewModel(
      CurrencyCoreContainer.getInstance().queryDispatcher,
      CurrencyCoreContainer.getInstance().commandDispatcher,
    );
  }
}

class CurrencyListNotification {}

class ResultCurrencyListNotification implements CurrencyListNotification {
  final List<CurrencyListReadModel>? currencyList;

  ResultCurrencyListNotification(this.currencyList);
}
