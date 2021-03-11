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

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'id':this.id,
      'name':this.name,
      'symbol':this.symbol,
      'fraction':this.fraction
    };
    return map;
  }
}
