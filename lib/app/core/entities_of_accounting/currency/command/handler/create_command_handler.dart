import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';

class CurrencyCreateCommandHandler extends BaseCommandHandler<CurrencyCreateCommand> {
  final BaseCommandValidator<CurrencyCreateCommand> validator;
  final CurrencyBaseRepository repository;

  CurrencyCreateCommandHandler({@required this.validator, @required this.repository});

  @override
  Future<void> execute(CurrencyCreateCommand command) async {
    this.validator.validate(command);
    UsesCurrencyDomainModel model =
        UsesCurrencyDomainModel(id: command.id, name: command.name, symbol: command.symbol, fraction: command.fraction);
    this.repository.save(model);
  }
}
