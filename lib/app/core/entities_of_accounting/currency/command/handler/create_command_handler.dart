import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';

class CurrencyCreateCommandHandler extends BaseCommandHandler<CurrencyCreateCommand> {
  final BaseCommandValidator<CurrencyCreateCommand> validator;
  final CurrencyBaseRepository repository;

  CurrencyCreateCommandHandler({required this.validator, required this.repository});

  @override
  Future<void> execute(CurrencyCreateCommand command) async {
    await validator.validate(command);
    CurrencyDomainModel model = CurrencyDomainModel(
      id: command.id,
      isNew: command.isNew,
      name: command.name,
      symbol: command.symbol,
      fraction: command.fraction,
      avatarColor: command.avatarColor,
      isDefault: command.isDefault,
    );
    await repository.save(model);
    EventBusCore.getInstance().addEvent(CurrencyChangedEvent());
  }
}
