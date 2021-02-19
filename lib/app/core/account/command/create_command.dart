import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';

class AccountCreateCommand extends BaseCommand {
  final String name;
  final String type;
  final bool isActive;
  final bool isSavingAccount;
  final UriData icoUri;
  final UsesCurrencyDomainModel currency;
  double balance;

  AccountCreateCommand(
      {@required this.name,
      @required this.type,
      @required this.isActive,
      @required this.isSavingAccount,
      this.icoUri,
      @required this.currency,
      this.balance = 0});
}
