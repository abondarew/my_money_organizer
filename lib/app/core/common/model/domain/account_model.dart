import 'package:mymoneyorganizer/app/core/common/model/domain/base_domain_model.dart';
import 'package:uuid/uuid.dart';

//Денежный счет

class AccountDomainModel implements BaseDomainModel {
  final String id;
  final String accountTypeId; //Тип счета (нал, карта, р/с, пр.). Ссылка на type_account_model.dart
  final String accountName;
  final bool isActive;
  final bool isSavingAccount; //Признак сберегательного счета. Используется в "Целях и Задачах"
  final UriData? icoUri;
  final String accountCurrencyId;
  final double accountBalance; //Текущий баланс счета. Меняется при каждой проводке, хранится явно в БД
  final bool isNew;

  AccountDomainModel._({
    required this.id,
    required this.isNew,
    required this.accountTypeId,
    required this.accountName,
    required this.isActive,
    required this.isSavingAccount,
    this.icoUri,
    required this.accountCurrencyId,
    required this.accountBalance,
  });

  factory AccountDomainModel({
    String? id,
    required String accountTypeId,
    required String accountName,
    required bool isActive,
    required bool isSavingAccount,
    UriData? icoUri,
    required String accountCurrencyId,
    required double accountBalance,
  }) {
    bool isNew = false;
    if (id == null) {
      isNew = true;
      id = const Uuid().v4();
    }
    return AccountDomainModel._(
      id: id,
      isNew: isNew,
      accountTypeId: accountTypeId,
      accountName: accountName,
      isActive: isActive,
      isSavingAccount: isSavingAccount,
      icoUri: icoUri,
      accountCurrencyId: accountCurrencyId,
      accountBalance: accountBalance,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'accountTypeId': accountTypeId,
      'accountName': accountName,
      'isActive': isActive,
      'isSavingAccount': isSavingAccount,
      'icoUri': icoUri,
      'accountCurrencyId': accountCurrencyId,
      'accountBalance': accountBalance,
    };
    return map;
  }
}
