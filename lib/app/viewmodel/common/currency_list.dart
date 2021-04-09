import 'dart:async';

import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/fetch_currency_list.dart';
import 'package:mymoneyorganizer/app/infrastructure/container/currency_core_container.dart';

class CurrencyListViewModel {
  final CurrencyQueryDispatcher _queryDispatcher;
  //EventBusCore eventBus = EventBusCore.getInstance();
  final StreamController<CurrencyListNotification> _eventController = StreamController.broadcast();

  Stream<CurrencyListNotification> get event{
    return _eventController.stream;
  }

  CurrencyListViewModel(this._queryDispatcher);

  Future<void> load() async {
    List<CurrencyListReadModel> result = await _queryDispatcher.dispatch(CurrencyQueryFetchList());
    this._eventController.add(ResultCurrencyListNotification(result));
  }

  void dispose(){
    this._eventController.close();
  }

  delete(List<CurrencyListReadModel> currencyList) {}

}

class CurrencyListViewModelBuilder {
  static CurrencyListViewModel build() {
    return CurrencyListViewModel(CurrencyCoreContainer.getInstance().queryDispatcher);
  }
}

class CurrencyListNotification{}

class ResultCurrencyListNotification implements CurrencyListNotification{
  final List<CurrencyListReadModel> currencyList;
  ResultCurrencyListNotification(this.currencyList);
}
