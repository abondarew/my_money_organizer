import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';

class CurrencyListNotification{}

class ResultCurrencyListNotification implements CurrencyListNotification{
  final List<UsesCurrencyReadModel> result;

  ResultCurrencyListNotification(this.result);
}