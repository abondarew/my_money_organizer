import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ValidatorList extends BaseValidator {
  final List<BaseValidator> _validators = [];

  ValidatorList(List<BaseValidator> validators) {
    _validators.addAll(validators);
  }

  void addValidator(BaseValidator validator) {
    _validators.add(validator);
  }

  @override
  Future<bool> validate(value) async {
    List<Future<bool>> lst = [];
    for (var element in _validators) {
      lst.add(element.validate(value));
    }
    List<bool> resList = await Future.wait(lst);
    for (var element in _validators) {
      addErrors(element.getErrors());
    }
    return !resList.any((element) => !element);
  }
}
