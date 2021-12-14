import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

class ValueIsNotIntValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (value == null || value is! int) {
      addError(value == null
          ? t('errors.num.is_empty')
          : t('errors.num.no_num')); //'${S.current.is_null} or not integer'); //TODO translate this!
      //print('ERROR!!!');
      return false;
    }
    return true;
  }
}
