import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';

/*
class CurrencyListNotification<List<UsesCurrencyReadModel>> extends BaseEventWithData<List<UsesCurrencyReadModel>>{
  CurrencyListNotification(eventData) : super(eventData);
}

class ResultCurrencyListNotification extends CurrencyListNotification{
  ResultCurrencyListNotification(eventData) : super(eventData);
  //final List<UsesCurrencyReadModel> result;

  //ResultCurrencyListNotification(eventData) : super(eventData);
}*/

class CurrencyListChangedWithDataEvent extends CurrencyChangedEvent{
  final List<UsesCurrencyListReadModel> data;

  CurrencyListChangedWithDataEvent(this.data);
}