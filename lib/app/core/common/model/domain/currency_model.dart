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
      {required this.id,
      required this.name,
      required this.symbol,
      required this.fraction,
      required this.isNew,
      required this.avatarColor,
      required this.isDefault});

  factory CurrencyDomainModel(
      {required String id,
      required String name,
      required String symbol,
      required int fraction,
      required int avatarColor,
      required bool isDefault,
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

  factory CurrencyDomainModel.fromMap(Map<String, dynamic> data) {
    return CurrencyDomainModel(
        id: data['id'],
        name: data['name'],
        symbol: data['symbol'],
        fraction: data['fraction'],
        avatarColor: data['color'],
        isDefault: data['isDefault'] == 1 ? true : false);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'name': this.name,
      'color': this.avatarColor,
      'symbol': this.symbol,
      'fraction': this.fraction,
      'isDefault ': this.isDefault ? 1 : 0,
    };
    return map;
  }
}
