import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/validator/color.dart';
import 'package:mymoneyorganizer/app/core/common/validator/container.dart';
import 'package:mymoneyorganizer/app/core/common/validator/list.dart';
import 'package:mymoneyorganizer/app/core/common/validator/string_not_empty.dart';
import 'package:mymoneyorganizer/app/core/common/validator/value_is_int.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/create_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/exception/create_command_exception.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/service/currency_not_exist.dart';

import 'currency_exist_validator.dart';

class CurrencyCreateCommandValidator extends BaseCommandValidator<CurrencyCreateCommand> {
  //final CurrencyBaseRepository repository;
  final ServiceCurrencyIsExist serviceCurrencyNotExist;

  CurrencyCreateCommandValidator({required this.serviceCurrencyNotExist});

  @override
  Future<void> validate(CurrencyCreateCommand command) async {
    ValidatorContainer container = ValidatorContainer();

    ValidatorList code = ValidatorList([StringNotEmptyValidator()]);
    if (command.isNew) {
      code.addValidator(CurrencyNotExistValidator(serviceCurrencyNotExist));
    }
    ValidatorList name = ValidatorList([StringNotEmptyValidator()]);
    ValidatorList symbol = ValidatorList([StringNotEmptyValidator()]);
    ValidatorList fraction = ValidatorList([ValueIsIntValidator()]);
    ValidatorList color = ValidatorList([ColorValidator()]);
    container
      ..add(code, command.id)
      ..add(name, command.name)
      ..add(symbol, command.symbol)
      ..add(fraction, command.fraction)
      ..add(color, command.avatarColor);
    bool res = await container.isValid();
    if (!(res)) {
      throw CurrencyCreateCommandException(id: code.errors, name: name.errors, symbol: symbol.errors, fraction: fraction.errors);
    }
  }
}
