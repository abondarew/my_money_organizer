import 'package:mymoneyorganizer/app/core/common/base/query/base_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/exceptions.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/query/handler/account_query_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/query/handler/list_query_handler.dart';

import '../fetch_account.dart';
import '../fetch_account_list.dart';

class AccountQueryDispatcher extends BaseQueryDispatcher {
  final FetchAccountListQueryHandler listQueryHandler;
  final FetchAccountQueryHandler accountQueryHandler;

  const AccountQueryDispatcher({required this.accountQueryHandler, required this.listQueryHandler});

  @override
  Future<dynamic> dispatch(BaseQuery query) async {
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
      throw InvalidQueryException('query not identified!'); //TODO translate this!
    }
  }
}
