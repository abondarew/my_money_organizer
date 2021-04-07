import 'package:flutter/foundation.dart';

class CurrencyListReadModel {
  final String id;
  final String symbol;
  final String name;

  CurrencyListReadModel({@required this.id, @required this.symbol, @required this.name});
}

class CurrencyDetailReadModel {
  final String id;
  final String name;
  final String symbol;
  final int fraction;

  CurrencyDetailReadModel({@required this.id, @required this.name, @required this.symbol, @required this.fraction});

  factory CurrencyDetailReadModel.fromMap(Map<String, dynamic> map) {
    return CurrencyDetailReadModel(id: map['id'].toString(), name: map['name'].toString(), symbol: map['symbol'].toString(), fraction: map['fraction']);
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'symbol': this.symbol, 'fraction': this.fraction};
  }
}
