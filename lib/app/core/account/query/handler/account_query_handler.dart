import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/query/fetch_account.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';

class FetchAccountQueryHandler implements BaseQueryHandler<FetchAccount, AccountReadModel> {
  final AccountBaseRepository repository;
  
  FetchAccountQueryHandler({@required this.repository});

  @override
  Future<AccountReadModel> execute(FetchAccount query) {
    return repository.fetchAccount(query: query);
  }
  
}