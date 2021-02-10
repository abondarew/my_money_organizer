import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/query/fetch_account_list.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';

class FetchAccountListQueryHandler implements BaseQueryHandler<FetchAccountListQuery, List<AccountReadModel>> {
  final AccountBaseRepository repository;

  FetchAccountListQueryHandler({@required this.repository});

  @override
  Future<List<AccountReadModel>> execute(FetchAccountListQuery query) {
    return repository.fetchAccountList(query: query);
  }
}
