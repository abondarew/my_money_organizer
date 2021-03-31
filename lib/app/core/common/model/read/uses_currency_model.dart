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
  final double fraction;

  UsesCurrencyDetailReadModel({@required this.id, @required this.name, @required this.symbol, @required this.fraction});
}
