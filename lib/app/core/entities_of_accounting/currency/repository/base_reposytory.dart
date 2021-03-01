import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';

abstract class CurrencyBaseRopesitory{
  Future<void> save(UsesCurrencyDomainModel model);

  Future<List<UsesCurrencyDomainModel>> fetchCurrencyList();

  Future<UsesCurrencyReadModel> getCurrencyFromId(String id);
}