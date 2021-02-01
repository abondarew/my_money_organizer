import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';

abstract class AccountBaseRepository {
  // save account
  Future<void> save(AccountDomainModel account);

  // delete account
  Future<void> delete(String id);

  // fetch list
  Future<List<AccountReadModel>> fetchAccountList();

  Future<bool> accountIsUse(String accountId);
}
