import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class StringNotEmptyValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (!(value is String)) {
      this.addError(S.current.not_a_string);
      return false;
    } else {
      String strValidate = value;
      if (strValidate.isEmpty) {
        this.addError(S.current.string_empty);
        return false;
      }
    }
    return true;
  }
}
