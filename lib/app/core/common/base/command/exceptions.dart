import 'package:mymoneyorganizer/generated/l10n.dart';
class BaseCommandException implements Exception {}

class InvalidCommandException implements BaseCommandException{
  final String message;

  const InvalidCommandException ([this.message]);

  @override
  String toString() {
    if (this.message == null){
      return S.current.invalid_command_exception;
    }
    return "${S.current.invalid_command_exception}: "+this.message;
  }
}
