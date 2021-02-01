import 'package:mymoneyorganizer/core/common/validator/base_validator.dart';

class ValueNotNullValidator extends BaseValidator {
  @override
  Future<void> validate(value) async {
    if (value == null) {
      this.addError("error! value is null");
    }
  }
}
