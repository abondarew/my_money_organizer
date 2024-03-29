import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';

abstract class BaseCommandHandler<T extends BaseCommand>{

  Future<void> execute(T command);
}