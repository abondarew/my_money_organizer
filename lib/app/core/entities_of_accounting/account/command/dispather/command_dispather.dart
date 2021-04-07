/*Диспетчер команд для счетов. Держит хендлеры на создание, обновление, изменение и удаление счета,
 / инициирует вызов execute хендлера
 */
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/open_close_account_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/command/update_command.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class AccountCommandDispatcher extends BaseCommandDispatcher {
  final BaseCommandHandler<AccountCreateCommand> createCommandHandler;
  final BaseCommandHandler<AccountDeleteCommand> deleteCommandHandler;
  final BaseCommandHandler<UpdateAccountCommand> updateCommandHandler;

  /*
  /   Конструктор принимает все доступные хендлеры
  */
  const AccountCommandDispatcher(
      {@required this.createCommandHandler, @required this.deleteCommandHandler, @required this.updateCommandHandler});

  /*Метод диспетчера: в зависимости от переданной команды отправляет ее (команду) в нужный хендлер
    если команда не найдена - бросает исключение
   */
  Future<void> dispatch(BaseCommand command) async {
    bool commandIsExecuting = false;
    if (command is AccountCreateCommand) {
      commandIsExecuting = true;
      createCommandHandler.execute(command);
    }
    if (command is AccountDeleteCommand) {
      commandIsExecuting = true;
      deleteCommandHandler.execute(command);
    }
    if (command is AccountUpdateSignOfActivity) {
      commandIsExecuting = true;
      updateCommandHandler.execute(command);
    }
    if (!commandIsExecuting) {
      throw InvalidCommandException(S.current.command_not_identifier);
    }
  }
}
