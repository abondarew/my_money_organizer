 /*Диспетчер команд для счетов. Держит хендлеры на создание, обновление, изменение и удаление счета,
 / инициирует вызов execute хендлера
 */
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/account/command/open_close_account_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';

class AccountCommandDispatcher {
  final BaseCommandHandler<AccountCreateCommand> createCommandHandler;
  final BaseCommandHandler<AccountDeleteCommand> deleteCommandHandler;
  final BaseCommandHandler<AccountUpdateSignOfActivity> updateSignOfActivityHandler;

  /* Конструктор принимает все доступные хендлеры

  */
  const AccountCommandDispatcher(
      {@required this.createCommandHandler,
      @required this.deleteCommandHandler,
      @required this.updateSignOfActivityHandler});

   /*Метод диспетчера: в зависимости от переданной команды отправляет ее (команду) в нужный хендлер
    если команда не найдена - бросает исключение
   */
  Future<void> dispatch(BaseCommand command){
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
      updateSignOfActivityHandler.execute(command);
    }
    if (!commandIsExecuting){
      throw InvalidCommandException("command not identified");
    }
  }
}
