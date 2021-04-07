import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/get_currency_from_id.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';

class CurrencyQueryHandlerGetFromId extends BaseQueryHandler<CurrencyQueryGetFromId, CurrencyDetailReadModel>{
  final CurrencyBaseRepository repository;

  CurrencyQueryHandlerGetFromId({@required this.repository});

  @override
  Future<CurrencyDetailReadModel> execute(CurrencyQueryGetFromId query) async {
    return repository.getCurrencyFromId(query.id);
  }

}