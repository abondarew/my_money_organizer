import 'package:mymoneyorganizer/app/core/common/model/domain/currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';

abstract class CurrencyBaseRepository{
  Future<void> save(CurrencyDomainModel model);

  Future<void> delete (String id);

  Future<List<CurrencyListReadModel>> fetchCurrencyList();

  Future<CurrencyDetailReadModel?> getCurrencyFromId(String id);

  Future<bool> currencyIsExist(String? id);
}