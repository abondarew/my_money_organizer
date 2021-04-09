import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/account/repository/base_repository.dart';

class AccountCanBeDeleteValidator extends BaseValidator{
  final AccountBaseRepository repository;

  AccountCanBeDeleteValidator({@required this.repository});

  @override
  Future<bool> validate(value) async {
    //TODO
    throw UnimplementedError();
  }
}