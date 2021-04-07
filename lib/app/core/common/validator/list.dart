import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ValidatorList extends BaseValidator {
  final List<BaseValidator> _validators = [];

  ValidatorList(List<BaseValidator> validators) {
    this._validators.addAll(validators);
  }

  void addValidator(BaseValidator validator) {
    this._validators.add(validator);
  }

  @override
  Future<bool> validate(value) async {
    List<Future<bool>> lst = [];
    this._validators.forEach((element) async {
      lst.add(element.validate(value));
    });
    List<bool> resList = await Future.wait(lst);
    this._validators.forEach((element) {
      this.addErrors(element.getErrors());
    });
    return !resList.any((element) => !element);
  }
}
