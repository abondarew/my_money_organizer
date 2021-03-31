import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';

class AccountReadModel {
  final String id;
  final String accountType;
  final String accountName;
  final UriData icoURI;
  final UsesCurrencyListReadModel currency;
  final double accountBalance;

  AccountReadModel(
      {@required this.id,
      @required this.accountType,
      @required this.accountName,
      @required this.icoURI,
      @required this.currency,
      @required this.accountBalance});
}
