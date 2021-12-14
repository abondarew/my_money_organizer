abstract class BaseValidator {
  // List ошибок
  final List<String> errors = [];

  //Карта перехода к ошибкам
  final Map<String, dynamic> mapErrors = Map();

  Future<bool> isValid(var value) async {
    return await validate(value);
  }

  Future<bool> validate(var value);

  void addError(String error) {
    errors.add(error);
  }

  void addErrors(List<String> errors) {
    this.errors.addAll(errors);
  }

  void addDataValue(String key, var value) {
    mapErrors[key] = value;
  }

  String? getError() {
    if (errors.isNotEmpty) {
      return errors.first;
    }
    return null;
  }

  List<String> getErrors() {
    return errors;
  }

  Map<String, dynamic> getValidatorData() {
    return mapErrors;
  }
}
