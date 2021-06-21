class CurrencyListReadModel {
  final String id;
  final String symbol;
  final String name;
  final int? avatarColor;
  final bool? isDefault;
  bool? selected = false;

  CurrencyListReadModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.avatarColor,
    required this.isDefault,
  });

  factory CurrencyListReadModel.fromMap(Map<String, dynamic> data) {
    return CurrencyListReadModel(
        id: data['id'].toString(),
        symbol: data['symbol'].toString(),
        name: data['name'].toString(),
        avatarColor: data['color'],
        isDefault: data['isDefault'] == 1 ? true : false);
  }
}

class CurrencyDetailReadModel {
  final String id;
  final String name;
  final String symbol;
  final int? fraction;
  final int? avatarColor;
  final bool? isDefault;

  CurrencyDetailReadModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.fraction,
    required this.avatarColor,
    required this.isDefault,
  });

  factory CurrencyDetailReadModel.fromMap(Map<String, dynamic> map) {
    return CurrencyDetailReadModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      symbol: map['symbol'].toString(),
      fraction: map['fraction'],
      avatarColor: map['color'],
      isDefault: map['isDefault'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'symbol': this.symbol,
      'fraction': this.fraction,
      'color': this.avatarColor,
      'isDefault': this.isDefault,
    };
  }
}
