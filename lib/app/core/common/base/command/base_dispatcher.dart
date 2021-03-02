import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

abstract class BaseCommandDispatcher {
  const BaseCommandDispatcher();

  Future<void> dispatch(BaseCommand c);
}
