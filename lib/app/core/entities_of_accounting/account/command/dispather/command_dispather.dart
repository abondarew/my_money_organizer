 /*Диспетчер команд для счетов. Держит хендлеры на создание, обновление, изменение и удаление счета,
 / инициирует вызов execute хендлера
 */
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';

import '../create_command.dart';
import '../delete_command.dart';
import '../open_close_account_command.dart';
import '../update_command.dart';

class AccountCommandDispatcher {
  final BaseCommandHandler<AccountCreateCommand> createCommandHandler;
  final BaseCommandHandler<AccountDeleteCommand> deleteCommandHandler;
  final BaseCommandHandler<UpdateAccountCommand> updateCommandHandler;

  /*
  /   Конструктор принимает все доступные хендлеры
  */
  const AccountCommandDispatcher(
      {@required this.createCommandHandler,
      @required this.deleteCommandHandler,
      @required this.updateCommandHandler});

   /*Метод диспетчера: в зависимости от переданной команды отправляет ее (команду) в нужный хендлер
    если команда не найдена - бросает исключение
   */
  Future<void> dispatch(BaseCommand command) async {
    bool commandIsExecuting = false;
    if (command is AccountCreateCommand){
      commandIsExecuting = true;
      createCommandHandler.execute(command);
    }
    if (command is AccountDeleteCommand){
      commandIsExecuting = true;
      deleteCommandHandler.execute(command);
    }
    if (command is AccountUpdateSignOfActivity){
      commandIsExecuting = true;
      updateCommandHandler.execute(command);
    }
    if (!commandIsExecuting){
      throw InvalidCommandException("command not identified");
    }
  }
}
