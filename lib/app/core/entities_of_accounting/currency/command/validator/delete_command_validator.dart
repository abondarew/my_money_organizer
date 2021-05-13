import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/delete_command.dart';

class CurrencyDeleteCommandValidator extends BaseCommandValidator<CurrencyDeleteCommand>{
  @override
  Future<void> validate(CurrencyDeleteCommand command) async{
    // TODO: add currency delete validator
  }

}