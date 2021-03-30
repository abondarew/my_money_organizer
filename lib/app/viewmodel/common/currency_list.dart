import 'dart:async';

import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
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
    List<UsesCurrencyReadModel> result = await _queryDispatcher.dispatch(CurrencyQueryFetchList());
    //eventBus.addEvent(CurrencyListChangedWithDataEvent(result));
    this._eventController.add(ResultCurrencyListNotification(result));
  }

  void dispose(){
    this._eventController.close();
  }

}

class CurrencyListViewModelBuilder {
  static CurrencyListViewModel build() {
    return CurrencyListViewModel(CurrencyCoreContainer.getInstance().queryDispatcher);
  }
}

class CurrencyListNotification{}

class ResultCurrencyListNotification implements CurrencyListNotification{
  final List<UsesCurrencyReadModel> currencyList;
  ResultCurrencyListNotification(this.currencyList);
}
