import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/fetch_currency_list.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';

class CurrencyQueryHandlerFetchList extends BaseQueryHandler<CurrencyQueryFetchList, List<UsesCurrencyListReadModel>>{
  final CurrencyBaseRepository repository;

  CurrencyQueryHandlerFetchList ({@required this.repository});

  @override
  Future<List<UsesCurrencyListReadModel>> execute(CurrencyQueryFetchList query) async {
    return repository.fetchCurrencyList();
  }

}