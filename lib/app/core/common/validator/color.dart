import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

class ColorValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (value is! int || value < 0 || value > 0xFFFFFFFF) {
      addError(t('errors.color.invalid'));
      return false;
    }
    return true;
  }
}
