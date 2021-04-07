import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ValidatorContainer {
  final List<_ContainerValidatorItem> _validators = [];

  Future<bool> isValid() async {
    List<Future<bool>> lst = [];
    _validators.forEach((element) async {
      lst.add(element.validator.isValid(element.value));
    });
    bool res = false;
    List l = await Future.wait(lst);
    res = !l.any((element) => !element);
    return res;
  }

  void add(BaseValidator validator, dynamic value) {
    this._validators.add(_ContainerValidatorItem(validator: validator, value: value));
  }
}

class _ContainerValidatorItem {
  final BaseValidator validator;

  final dynamic value;

  const _ContainerValidatorItem({@required this.validator, @required this.value});
}
