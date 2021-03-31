import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/dispatcher/query_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/get_currency_from_id.dart';

class CurrencyDetailViewModel{
  final CurrencyQueryDispatcher _queryDispatcher;
  final StreamController<CurrencyDetailNotification> eventController = StreamController<CurrencyDetailNotification>.broadcast();
  UsesCurrencyDetailReadModel model;
  bool _isNew = true;
  bool _isModification = false;

  CurrencyDetailViewModel(this._queryDispatcher);

  void dispose(){
    eventController.close();
  }

  Future<void> load({String id}) async {
    if (id != null){
      _isNew = false;
      model = await _queryDispatcher.dispatch(CurrencyQueryGetFromId(id: id));
    }
    eventController.add(ResultCurrencyDetailNotification(visibleSaveButton: _isModification, currencyReadModel: model));
  }

  void setModified(bool isModification){
    if(isModification != this._isModification){
      this._isModification = isModification;
      eventController.add(ResultCurrencyDetailNotification(visibleSaveButton: _isModification, currencyReadModel: model));
    }
  }
}

class CurrencyDetailNotification{}

class ResultCurrencyDetailNotification implements CurrencyDetailNotification{
  final UsesCurrencyDetailReadModel currencyReadModel;
  final bool visibleSaveButton;
  ResultCurrencyDetailNotification({this.currencyReadModel, @required this.visibleSaveButton});
}

class ErrorCurrencyDetailNotification implements CurrencyDetailNotification{
  final String error;
  ErrorCurrencyDetailNotification({this.error});
}