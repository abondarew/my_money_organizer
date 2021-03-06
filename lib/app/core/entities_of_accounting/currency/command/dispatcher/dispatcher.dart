import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/handler/create_command_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/handler/delete_command_handler.dart';

class CurrencyCommandDispatcher extends BaseCommandDispatcher{
  final CurrencyCreateCommandHandler createCommandHandler;
  final CurrencyDeleteCommandHandler deleteCommandHandler;

  CurrencyCommandDispatcher({@required this.createCommandHandler, @required this.deleteCommandHandler});

  @override
  Future<void> dispatch(BaseCommand c) async {
    bool commandIsExecuting = false;

    if(c is CurrencyCreateCommand){
      commandIsExecuting = true;
      createCommandHandler.execute(c);
    }
    if(c is CurrencyDeleteCommand){
      commandIsExecuting = true;
      deleteCommandHandler.execute(c);
    }

    if(!commandIsExecuting){
      throw InvalidCommandException("not found");
    }
  }
}