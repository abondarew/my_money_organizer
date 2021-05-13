import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/service/currency_not_exist.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyNotExistValidator extends BaseValidator {
  final ServiceCurrencyIsExist serviceCurrencyIsExist;

  CurrencyNotExistValidator(this.serviceCurrencyIsExist);

  @override
  Future<bool> validate(value) async {
    bool res = await serviceCurrencyIsExist.currencyIsExist(value);
    if (res) {
      this.addError(S.current.currency_exist);
    }
    return (!res);
  }

  @override
  Future<bool> isValid(value) {
    Future<bool> res = super.isValid(value);
    return res;
  }
}
