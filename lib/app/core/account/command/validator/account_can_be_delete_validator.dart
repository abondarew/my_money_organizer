import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/account/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class AccountCanBeDeleteValidator extends BaseValidator{
  final AccountBaseRepository repository;

  AccountCanBeDeleteValidator({@required this.repository});

  @override
  Future<void> validate(value) async {
    //bool accountIsUse = await
  }
  
}