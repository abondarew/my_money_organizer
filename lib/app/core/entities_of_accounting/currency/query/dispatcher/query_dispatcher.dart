import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/exceptions.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/fetch_currency_list.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/get_currency_from_id.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/handler/fetch_currency_list.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/query/handler/get_currency_from_id.dart';

class CurrencyQueryDispatcher extends BaseQueryDispatcher {
  final CurrencyQueryHandlerGetFromId handlerGetFromId;
  final CurrencyQueryHandlerFetchList handlerFetchList;

  const CurrencyQueryDispatcher({@required this.handlerFetchList, @required this.handlerGetFromId});

  @override
  Future<dynamic> dispatch(BaseQuery query) async {
    bool queryIsExecuting = false;
    if (query is CurrencyQueryGetFromId) {
      queryIsExecuting = true;
      return handlerGetFromId.execute(query);
    }
    if (query is CurrencyQueryFetchList) {
      queryIsExecuting = true;
      return handlerFetchList.execute(query);
    }

    if (!queryIsExecuting) {
      throw InvalidQueryException("  ");
    }
  }
}
