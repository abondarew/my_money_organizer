import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';

class ServiceCurrencyIsExist {
  final CurrencyBaseRepository repository;

  ServiceCurrencyIsExist({required this.repository});

  Future<bool> currencyIsExist(String? id) async {
    bool res = await repository.currencyIsExist(id);
    return res;
  }
}
