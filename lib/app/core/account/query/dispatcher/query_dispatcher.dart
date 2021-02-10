import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/query/fetch_account.dart';
import 'package:mymoneyorganizer/app/core/account/query/fetch_account_list.dart';
import 'package:mymoneyorganizer/app/core/account/query/handler/account_query_handler.dart';
import 'package:mymoneyorganizer/app/core/account/query/handler/list_query_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/exceptions.dart';

class AccountQueryDispatcher {
  final FetchAccountListQueryHandler listQueryHandler;
  final FetchAccountQueryHandler accountQueryHandler;

  AccountQueryDispatcher({@required this.accountQueryHandler, @required this.listQueryHandler});

  Future<dynamic> dispatch(BaseQuery query) {
    bool queryIsExecuting = false;
    if (query is FetchAccountListQuery) {
      queryIsExecuting = true;
      return listQueryHandler.execute(query);
    }
    if (query is FetchAccount) {
      queryIsExecuting = true;
      return accountQueryHandler.execute(query);
    }
    if (!queryIsExecuting) {
      throw InvalidQueryException('query not identified!');
    }
  }
}
