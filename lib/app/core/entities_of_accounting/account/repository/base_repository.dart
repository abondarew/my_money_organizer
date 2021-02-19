import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/query/fetch_account.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/query/fetch_account_list.dart';

abstract class AccountBaseRepository {
  // save account
  Future<void> save(AccountDomainModel account);

  // delete account
  Future<void> delete(AccountDeleteCommand command);

  // fetch list
  Future<List<AccountReadModel>> fetchAccountList({FetchAccountListQuery query});

  Future<AccountReadModel> fetchAccount({FetchAccount query});

  Future<bool> accountIsUse(String accountId);
}
