abstract class BaseValidator {
  // List ошибок
  final List<String> errors = List();

  //Карта перехода к ошибкам
  final Map<String, dynamic> mapErrors = Map();

  Future<bool> isValid(var value) async {
    await this.validate(value);

    return this.errors.isEmpty;
  }

  Future<void> validate(var value);

  void addError(String error) {
    this.errors.add(error);
  }

  void addErrors(List<String> errors) {
    this.errors.addAll(errors);
  }

  void addDataValue(String key, var value) {
    this.mapErrors[key] = value;
  }

  String getError() {
    if (this.errors.isNotEmpty) {
      return this.errors.first;
    }
    return null;
  }

  List<String> getErrors() {
    return this.errors;
  }

  Map<String, dynamic> getValidatorData() {
    return mapErrors;
  }
}
