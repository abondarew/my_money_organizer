import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/base_domain_model.dart';

class CurrencyDomainModel implements BaseDomainModel {
  final String id;
  final bool isNew;
  String name;
  String symbol;
  int fraction;
  int avatarColor;
  bool isDefault;

  CurrencyDomainModel._(
      {@required this.id,
      @required this.name,
      @required this.symbol,
      @required this.fraction,
      @required this.isNew,
      @required this.avatarColor,
      @required this.isDefault});

  factory CurrencyDomainModel(
      {@required String id,
      @required String name,
      @required String symbol,
      @required int fraction,
      @required int avatarColor,
      @required bool isDefault,
      bool isNew = false}) {
    return CurrencyDomainModel._(
      id: id,
      name: name,
      avatarColor: avatarColor,
      symbol: symbol,
      fraction: fraction,
      isDefault: isDefault,
      isNew: isNew,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'name': this.name,
      'color': this.avatarColor,
      'symbol': this.symbol,
      'fraction': this.fraction,
      'isDefault ': this.isDefault,
    };
    return map;
  }

  @override
  CurrencyDomainModel fromMap(Map<String, dynamic> map) {
    return (CurrencyDomainModel(
      id: map['id'],
      name: map['name'],
      avatarColor: map['color'],
      symbol: map['symbol'],
      fraction: map['fraction'],
      isDefault: map['isDefault'],
    ));
  }
}
