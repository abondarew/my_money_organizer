import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/delete_command_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';

class CurrencyDeleteCommandHandler extends BaseCommandHandler<CurrencyDeleteCommand>{
  final CurrencyBaseRepository repository;
  final CurrencyDeleteCommandValidator validator;

  CurrencyDeleteCommandHandler({@required this.repository, @required this.validator});

  @override
  Future<void> execute(CurrencyDeleteCommand command) async {
    await validator.validate(command);
    List<Future<void>> executeLst = [];
    command.listId.forEach((element) {
      executeLst.add(repository.delete(element));
    });
    Future.wait(executeLst);
    EventBusCore.getInstance().addEvent(CurrencyChangedEvent());
  }

}