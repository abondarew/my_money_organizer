import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/base_domain_model.dart';

class UsesCurrencyDomainModel implements BaseDomainModel{
  final String id;
  final bool isNew;
  String name;
  String symbol;
  int fraction;

  UsesCurrencyDomainModel._(
      {@required this.id,
      @required this.name,
      @required this.symbol,
      @required this.fraction,
      @required this.isNew});

  factory UsesCurrencyDomainModel(
      {@required String id,
      @required String name,
      @required String symbol,
      @required int fraction,
      bool isNew = false}) {
    return UsesCurrencyDomainModel._(
        id: id, name: name, symbol: symbol, fraction: fraction, isNew: isNew);
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

  @override
  UsesCurrencyDomainModel fromMap(Map<String, dynamic> map) {
    return(UsesCurrencyDomainModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      fraction: map['fraction']
    ));
  }
}
