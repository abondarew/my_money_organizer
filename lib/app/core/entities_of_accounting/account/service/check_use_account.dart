import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

import 'contract/check_use_account_contract.dart';

class CheckUseAccount implements CheckUseAccountContract {
  final AccountBaseRepository _repository;

  CheckUseAccount(this._repository);

  @override
  Future<bool> accountFromIdIsUse(String id) {
    return _repository.accountIsUse(id);
  }

  @override
  Future<bool> accountIsUse(AccountDomainModel account) {
    return this.accountFromIdIsUse(account.id);
  }
}
