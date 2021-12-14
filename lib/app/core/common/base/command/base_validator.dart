import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

abstract class BaseCommandValidator<T extends BaseCommand> {
  Future<void> validate(T command);
}
