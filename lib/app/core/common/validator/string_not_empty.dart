import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

class StringNotEmptyValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (value is! String) {
      addError(t('errors.string.no_string'));
      return false;
    } else {
      String strValidate = value;
      if (strValidate.isEmpty) {
        addError(t('errors.string.is_empty'));
        return false;
      }
    }
    return true;
  }
}
