import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ValidatorContainer {
  final List<_ContainerValidatorItem> _validators = [];

  Future<bool> isValid() async {
    List<Future<bool>> lst = [];
    for (var element in _validators) {
      lst.add(element.validator.isValid(element.value));
    }
    bool res = false;
    List l = await Future.wait(lst);
    res = !l.any((element) => !element);
    return res;
  }

  void add(BaseValidator validator, dynamic value) {
    _validators.add(_ContainerValidatorItem(validator: validator, value: value));
  }
}

class _ContainerValidatorItem {
  final BaseValidator validator;

  final dynamic value;

  const _ContainerValidatorItem({required this.validator, required this.value});
}
