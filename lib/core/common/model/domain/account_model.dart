import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class AccountDomainModel {
  final String id;
  String accountType;
  String accountName;
  bool isActive;
  bool isSavingAccount;
  UriData icoUri;
  UsesCurrencyDomainModel accountCurrency;

  AccountDomainModel._(
      {@required this.id,
      @required this.accountType,
      @required this.accountName,
      @required this.isActive,
      @required this.isSavingAccount,
      this.icoUri,
      @required this.accountCurrency});

  factory AccountDomainModel(
      {String id,
      @required String accountType,
      @required String accountName,
      @required bool isActive,
      @required bool isSavingAccount,
      UriData icoUri,
      @required UsesCurrencyDomainModel accountCurrency}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return AccountDomainModel._(
        id: id,
        accountType: accountType,
        accountName: accountName,
        isActive: isActive,
        isSavingAccount: isSavingAccount,
        icoUri: icoUri,
        accountCurrency: accountCurrency);
  }
}
