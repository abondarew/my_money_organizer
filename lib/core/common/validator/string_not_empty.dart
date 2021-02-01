import 'package:mymoneyorganizer/core/common/validator/base_validator.dart';

class StringNotEmptyValidator extends BaseValidator {
  @override
  Future<void> validate(value) async {
    if (!(value is String)) {
      this.addError("value is not a string!");
    } else {
      String strValidate = value;
      if (strValidate.isEmpty) {
        this.addError("string is empty!");
      }
    }
  }
}
