import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import '../fetch_account.dart';

class FetchAccountQueryHandler implements BaseQueryHandler<FetchAccount, AccountReadModel> {
  final AccountBaseRepository repository;
  
  FetchAccountQueryHandler({@required this.repository});

  @override
  Future<AccountReadModel> execute(FetchAccount query) {
    return repository.fetchAccount(query: query);
  }
  
}