import 'package:mymoneyorganizer/app/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';

class AccountDeleteCommandHandler extends BaseCommandHandler<AccountDeleteCommand>{
  @override
  Future<void> execute(AccountDeleteCommand deleteCommand) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}