import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';

abstract class CurrencyBaseRepository{
  Future<void> save(UsesCurrencyDomainModel model);

  Future<List<UsesCurrencyReadModel>> fetchCurrencyList();

  Future<UsesCurrencyReadModel> getCurrencyFromId(String id);
}