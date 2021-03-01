import 'package:flutter/foundation.dart';

class UsesCurrencyDomainModel {
  final String id;
  String name;
  String symbol;
  int fraction;

  UsesCurrencyDomainModel._(
      {@required this.id,
      @required this.name,
      @required this.symbol,
      @required this.fraction});

  factory UsesCurrencyDomainModel(
      {@required String id,
      @required String name,
      @required String symbol,
      @required int fraction}) {
    return UsesCurrencyDomainModel._(
        id: id, name: name, symbol: symbol, fraction: fraction);
  }
}
