import 'package:mymoneyorganizer/app/core/common/base/query/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import '../fetch_account_list.dart';

class FetchAccountListQueryHandler implements BaseQueryHandler<FetchAccountListQuery, List<AccountReadModel>> {
  final AccountBaseRepository repository;

  FetchAccountListQueryHandler({required this.repository});

  @override
  Future<List<AccountReadModel>> execute(FetchAccountListQuery query) {
    return repository.fetchAccountList(query: query);
  }
}
