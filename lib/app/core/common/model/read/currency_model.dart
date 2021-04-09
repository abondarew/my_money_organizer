import 'package:flutter/foundation.dart';

class CurrencyListReadModel {
  final String id;
  final String symbol;
  final String name;
  final int avatarColor;
  bool selected = false;

  CurrencyListReadModel({@required this.id, @required this.symbol, @required this.name, @required this.avatarColor});
}

class CurrencyDetailReadModel {
  final String id;
  final String name;
  final String symbol;
  final int fraction;
  final int avatarColor;

  CurrencyDetailReadModel(
      {@required this.id, @required this.name, @required this.symbol, @required this.fraction, @required this.avatarColor});

  factory CurrencyDetailReadModel.fromMap(Map<String, dynamic> map) {
    return CurrencyDetailReadModel(
        id: map['id'].toString(),
        name: map['name'].toString(),
        symbol: map['symbol'].toString(),
        fraction: map['fraction'],
        avatarColor: map['color']);
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'symbol': this.symbol, 'fraction': this.fraction, 'color': this.avatarColor};
  }
}
