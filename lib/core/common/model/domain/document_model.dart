import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/core/common/model/domain/project_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/transaction_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class DocumentDomainModel {
  final String id;
  DateTime documentDateTime;
  double amount;
  ProjectDomainModel documentProject;
  UsesCurrencyDomainModel documentCurrency;
  double currencyAmount;
  String description;
  List<TransactionDomainModel> transactions;

  DocumentDomainModel._(
      {@required this.id,
      @required this.documentDateTime,
      @required this.amount,
      this.documentProject,
      @required this.documentCurrency,
      @required this.currencyAmount,
      this.description,
      @required this.transactions});

  factory DocumentDomainModel(
      {String id,
      @required DateTime documentDateTime,
      @required double amount,
      ProjectDomainModel documentProject,
      @required UsesCurrencyDomainModel documentCurrency,
      @required double currencyAmount,
      String description,
      List<TransactionDomainModel> transactions}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return DocumentDomainModel._(
        id: id,
        documentDateTime: documentDateTime,
        amount: amount,
        documentProject: documentProject,
        documentCurrency: documentCurrency,
        currencyAmount: currencyAmount,
        description: description,
        transactions: transactions);
  }
}
