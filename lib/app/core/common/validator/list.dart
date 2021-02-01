import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ListValidator extends BaseValidator {
  final List<BaseValidator> _validators = List();

  ListValidator(List<BaseValidator> validators) {
    this._validators.addAll(validators);
  }

  void addValidator(BaseValidator validator) {
    this._validators.add(validator);
  }

  @override
  Future<void> validate(value) async {
    this._validators.forEach((validator) async {
      validator.validate(value);
      this.addErrors(validator.getErrors());
    });
  }
}
