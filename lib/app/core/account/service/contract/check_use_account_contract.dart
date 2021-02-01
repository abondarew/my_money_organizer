import 'package:mymoneyorganizer/app/core/common/model/domain/account_model.dart';

abstract class CheckUseAccountContract {
  Future<bool> accountFromIdIsUse(String id);
  Future<bool> accountIsUse(AccountDomainModel account);
}
