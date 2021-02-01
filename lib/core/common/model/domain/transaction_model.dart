import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/core/common/model/domain/account_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/category_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class TransactionDomainModel {
  final String id;

  //String documentId; <-- ?
  int transactionNumber;
  AccountDomainModel account;
  CategoryDomainModel category;
  double amount;
  UsesCurrencyDomainModel currency;
  double currencyAmount;

  TransactionDomainModel._(
      {@required this.id,
      @required this.transactionNumber,
      @required this.account,
      @required this.category,
      @required this.amount,
      @required this.currency,
      @required this.currencyAmount});

  factory TransactionDomainModel(
      {String id,
      @required int transactionNumber,
      @required AccountDomainModel account,
      @required CategoryDomainModel category,
      @required double amount,
      @required UsesCurrencyDomainModel currency,
      @required double currencyAmount}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return TransactionDomainModel._(
        id: id,
        transactionNumber: transactionNumber,
        account: account,
        category: category,
        amount: amount,
        currency: currency,
        currencyAmount: currencyAmount);
  }
}
