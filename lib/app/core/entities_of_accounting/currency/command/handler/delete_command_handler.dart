import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/delete_command.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_reposytory.dart';

class CurrencyDeleteCommandHandler extends BaseCommandHandler<CurrencyDeleteCommand>{
  final CurrencyBaseRepository repository;

  CurrencyDeleteCommandHandler({@required this.repository});

  @override
  Future<void> execute(CurrencyDeleteCommand command) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}