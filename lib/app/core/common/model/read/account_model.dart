import 'package:flutter/foundation.dart';

class AccountReadModel {
  final String id;
  final String accountType;
  final String accountName;
  final UriData icoURI;
  final String currency;

  AccountReadModel(
      {@required this.id,
      @required this.accountType,
      @required this.accountName,
      @required this.icoURI,
      @required this.currency});
}
