import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ContainerValidator {
  final List<_ContainerValidatorItem> _validators = List();

  Future<bool> isValid() async {
    bool result = true;
    this._validators.forEach((validatorItem) async {
      result &= await validatorItem.validator.isValid(validatorItem.value);
    });
    return result;
  }

  void addValidator(BaseValidator validator, dynamic value) {
    this._validators.add(_ContainerValidatorItem(validator: validator, value: value));
  }
}

class _ContainerValidatorItem {
  final BaseValidator validator;

  final dynamic value;

  const _ContainerValidatorItem({@required this.validator, @required this.value});
}
