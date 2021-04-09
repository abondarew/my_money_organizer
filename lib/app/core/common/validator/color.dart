import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class ColorValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (!(value is int) || value < 0 || value > 0xFFFFFFFF) {
      this.addError(S.current.invalid_color);
      return false;
    }
    return true;
  }
}