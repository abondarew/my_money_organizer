import 'package:mymoneyorganizer/app/core/common/model/domain/base_domain_model.dart';

class CurrencyDomainModel implements BaseDomainModel {
  final String id;
  final bool isNew;
  final String name;
  final String symbol;
  final int fraction;
  final int avatarColor;
  final bool isDefault;

  CurrencyDomainModel._({
    required this.id,
    required this.name,
    required this.symbol,
    required this.fraction,
    required this.isNew,
    required this.avatarColor,
    required this.isDefault,
  });

  factory CurrencyDomainModel({
    required String id,
    required String name,
    required String symbol,
    required int fraction,
    required int avatarColor,
    required bool isDefault,
    bool isNew = false,
  }) {
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

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'color': avatarColor,
      'symbol': symbol,
      'fraction': fraction,
      'isDefault ': isDefault ? 1 : 0,
    };
    return map;
  }
}
