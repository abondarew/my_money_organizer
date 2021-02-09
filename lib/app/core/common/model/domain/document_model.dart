import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/project_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/transaction_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class DocumentDomainModel {
  @required final String id;
  @required bool isNew;
  @required DateTime documentEntryTimePoint;
  @required DateTime documentDateTime;
  @required double amount;
  ProjectDomainModel documentProject;
  @required UsesCurrencyDomainModel documentCurrency;
  @required double currencyAmount;
  String description;
  @required List<TransactionDomainModel> transactions;

  DocumentDomainModel._(
      {@required this.id,
      @required this.isNew,
      @required this.documentEntryTimePoint,
      @required this.documentDateTime,
      @required this.amount,
      this.documentProject,
      @required this.documentCurrency,
      @required this.currencyAmount,
      this.description,
      @required this.transactions});

  factory DocumentDomainModel(
      {String id,
      DateTime documentEntryTimePoint,
      @required DateTime documentDateTime,
      @required double amount,
      ProjectDomainModel documentProject,
      @required UsesCurrencyDomainModel documentCurrency,
      @required double currencyAmount,
      String description,
      List<TransactionDomainModel> transactions}) {
    bool isNew = false;
    if (id == null) {
      isNew = true;
      documentEntryTimePoint = DateTime.now();
      id = Uuid().v4();
    }
    if (transactions == null){
      transactions = List<TransactionDomainModel>();
    }
    return DocumentDomainModel._(
        id: id,
        isNew: isNew,
        documentEntryTimePoint: documentEntryTimePoint,
        documentDateTime: documentDateTime,
        amount: amount,
        documentProject: documentProject,
        documentCurrency: documentCurrency,
        currencyAmount: currencyAmount,
        description: description,
        transactions: transactions);
  }
}
