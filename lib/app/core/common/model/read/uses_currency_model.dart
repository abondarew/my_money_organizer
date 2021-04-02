import 'package:flutter/foundation.dart';

class UsesCurrencyListReadModel {
  final String id;
  final String symbol;
  final String name;

  UsesCurrencyListReadModel({@required this.id, @required this.symbol, @required this.name});
}

class UsesCurrencyDetailReadModel {
  final String id;
  final String name;
  final String symbol;
  final int fraction;

  UsesCurrencyDetailReadModel({@required this.id, @required this.name, @required this.symbol, @required this.fraction});

  factory UsesCurrencyDetailReadModel.fromMap(Map<String, dynamic> map) {
    return UsesCurrencyDetailReadModel(id: map['id'], name: map['name'], symbol: map['symbol'], fraction: map['fraction']);
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'symbol': this.symbol, 'fraction': this.fraction};
  }
}
