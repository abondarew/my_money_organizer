import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/core/common/model/domain/uses_currency_model.dart';

class AccountCreateCommand extends BaseCommand {
  final String name;
  final String type;
  final bool isActive;
  final bool isSavingAccount;
  final UriData icoUri;
  final UsesCurrencyDomainModel currency;

  AccountCreateCommand(
      {@required this.name,
      @required this.type,
      @required this.isActive,
      @required this.isSavingAccount,
      this.icoUri,
      @required this.currency});
}
