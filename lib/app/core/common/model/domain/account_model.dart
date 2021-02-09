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

  AccountDomainModel._(
      {@required this.id,
      @required this.accountTypeId,
      @required this.accountName,
      @required this.isActive,
      @required this.isSavingAccount,
      this.icoUri,
      @required this.accountCurrency});

  factory AccountDomainModel(
      {String id,
      @required String accountTypeId,
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
        accountTypeId: accountTypeId,
        accountName: accountName,
        isActive: isActive,
        isSavingAccount: isSavingAccount,
        icoUri: icoUri,
        accountCurrency: accountCurrency);
  }
}
