import 'dart:async';

import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/dispatcher/dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/get_currency_from_id.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/infrastructure/container/currency_core_container.dart';

class CurrencyDetailViewModel {
  final CurrencyQueryDispatcher _queryDispatcher;
  final CurrencyCommandDispatcher _commandDispatcher;
  final StreamController<CurrencyDetailNotification> eventController = StreamController<CurrencyDetailNotification>.broadcast();
  final Map<String, dynamic> newData = Map<String, dynamic>();
  CurrencyDetailReadModel? model;
  bool _isNew = true;
  bool _isModification = false;

  CurrencyDetailViewModel(this._queryDispatcher, this._commandDispatcher);

  void dispose() {
    eventController.close();
  }

  Future<void> load({String? id}) async {
    if (id != null) {
      _isNew = false;
      model = await _queryDispatcher.dispatch(CurrencyQueryGetFromId(id: id));
      newData.addAll(model!.toMap());
    } else {
      _isNew = true;
    }
    eventController.add(ResultCurrencyDetailNotification(currencyReadModel: model));
  }

  void updateData(String key, dynamic value) {
    newData[key] = value;
  }

  bool get isNew => _isNew;

  void setModified(bool isModification) {
    if (isModification != this._isModification) {
      this._isModification = isModification;
      eventController.add(CurrencyDetailModifiedNotification(isModified: _isModification));
    }
  }

  Stream<CurrencyDetailNotification> get event {
    return eventController.stream;
  }

  Future<void> save() async {
    //newData['color'] = 0xFF2233FF;
    try {
      await _commandDispatcher.dispatch(CurrencyCreateCommand(
        id: newData['id'],
        isNew: _isNew,
        name: newData['name'],
        symbol: newData['symbol'],
        fraction: newData['fraction'],
        avatarColor: newData['color'],
        isDefault: newData['isDefault'],
      ));
      EventBusCore.getInstance().addEvent(CurrencyChangedEvent());
      eventController.add(SuccessfulSaveCurrency());
    } catch (e) {
      eventController.add(ErrorCurrencyDetailNotification(error: e));
    } finally {}
  }
}

class CurrencyDetailViewModelBuilder {
  static CurrencyDetailViewModel build() {
    return CurrencyDetailViewModel(
        CurrencyCoreContainer.getInstance().queryDispatcher, CurrencyCoreContainer.getInstance().commandDispatcher);
  }
}

class CurrencyDetailNotification {}

class ResultCurrencyDetailNotification implements CurrencyDetailNotification {
  final CurrencyDetailReadModel? currencyReadModel;

  ResultCurrencyDetailNotification({this.currencyReadModel});
}

class CurrencyDetailModifiedNotification implements CurrencyDetailNotification {
  final bool? isModified;

  CurrencyDetailModifiedNotification({this.isModified});
}

class ErrorCurrencyDetailNotification implements CurrencyDetailNotification {
  final Object? error;

  ErrorCurrencyDetailNotification({this.error});
}

class SuccessfulSaveCurrency implements CurrencyDetailNotification {}
