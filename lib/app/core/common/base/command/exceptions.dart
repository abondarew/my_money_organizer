import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

class BaseCommandException implements Exception {}

class InvalidCommandException implements BaseCommandException {
  final String? message;

  const InvalidCommandException([this.message]);

  @override
  String toString() {
    if (message == null) {
      return t('errors.command.invalid'); //S.current.invalid_command_exception;
    }
    return "${t('errors.command.invalid')}: " + message!;
  }
}
