import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';

class ServiceCurrencyNotExist{
  final CurrencyBaseRepository repository;

  ServiceCurrencyNotExist({@required this.repository});

  Future<bool> currencyNotExist(String id) async{
    print('exist service start');
    bool res = await repository.currencyNotExist(id);
    print('exist service end');
    return res;
  }
}