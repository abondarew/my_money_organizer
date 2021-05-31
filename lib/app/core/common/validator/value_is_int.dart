import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class ValueIsIntValidator extends BaseValidator {
  @override
  Future<bool> validate(value) async {
    if (value == null || !(value is int)) {
      this.addError('${S.current.is_null} or not integer'); //TODO translate this!
      print('ERROR!!!');
      return false;
    }
    return true;
  }
}
