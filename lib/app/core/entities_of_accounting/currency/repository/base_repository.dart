import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';

abstract class CurrencyBaseRepository{
  Future<void> save(UsesCurrencyDomainModel model);

  Future<void> delete (String id);

  Future<List<UsesCurrencyListReadModel>> fetchCurrencyList();

  Future<UsesCurrencyDetailReadModel> getCurrencyFromId(String id);

  Future<bool> currencyNotExist(String id);
}