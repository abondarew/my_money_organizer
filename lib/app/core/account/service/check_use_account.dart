import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/account/service/contract/check_use_account_contract.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';

class CheckUseAccount implements CheckUseAccountContract {
  final AccountBaseRepository _repository;

  CheckUseAccount(this._repository);

  @override
  Future<bool> accountFromIdIsUse(String id) {
    // TODO: implement accountFromIdIsUse
    throw UnimplementedError();
  }

  @override
  Future<bool> accountIsUse(AccountDomainModel account) {
    return this.accountFromIdIsUse(account.id);
  }
}
