import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class ValueNotNullValidator extends BaseValidator {
  @override
  Future<void> validate(value) async {
    if (value == null) {
      this.addError(S.current.is_null);
    }
  }
}
