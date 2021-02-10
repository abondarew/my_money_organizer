import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class AccountDomainModel {
  final String id;
  String accountTypeId;
  String accountName;
  bool isActive;
  bool isSavingAccount;
  UriData icoUri;
  UsesCurrencyDomainModel accountCurrency;
  final double accountBalance;
  final bool isNew;

  AccountDomainModel._(
      {@required this.id,
      @required this.isNew,
      @required this.accountTypeId,
      @required this.accountName,
      @required this.isActive,
      @required this.isSavingAccount,
      this.icoUri,
      @required this.accountCurrency,
      @required this.accountBalance});

  factory AccountDomainModel(
      {String id,
      @required String accountTypeId,
      @required String accountName,
      @required bool isActive,
      @required bool isSavingAccount,
      UriData icoUri,
      @required UsesCurrencyDomainModel accountCurrency,
      @required double accountBalance}) {
    bool isNew = false;
    if (id == null) {
      isNew = true;
      id = Uuid().v4();
    }
    return AccountDomainModel._(
        id: id,
        isNew: isNew,
        accountTypeId: accountTypeId,
        accountName: accountName,
        isActive: isActive,
        isSavingAccount: isSavingAccount,
        icoUri: icoUri,
        accountCurrency: accountCurrency,
        accountBalance: accountBalance);
  }
}
