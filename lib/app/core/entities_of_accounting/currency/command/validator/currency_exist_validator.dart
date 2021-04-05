import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/service/currency_not_exist.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyNotExistValidator extends BaseValidator{
  final ServiceCurrencyNotExist serviceCurrencyNotExist;

  CurrencyNotExistValidator(this.serviceCurrencyNotExist);

  @override
  Future<void> validate(value) async{
    print('exist');
    bool res = await serviceCurrencyNotExist.currencyNotExist(value);
    print('res exist = $res');
    if(res){
      print('exist - add error');
      this.addError(S.current.currency_exist);
    }
  }

}