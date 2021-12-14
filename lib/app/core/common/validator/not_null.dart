import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

class ValueNotNullValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (value == null) {
      addError(t('errors.value.is_empty'));
      return false;
    }
    return true;
  }
}
