import 'package:mymoneyorganizer/app/core/common/model/domain/currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class CurrencyDatabaseRepository implements CurrencyBaseRepository {
  DatabaseBaseConnection _databaseBaseConnection;
  final String _tableName = 'uses_currency';

  CurrencyDatabaseRepository(this._databaseBaseConnection);

  Future<void> save(CurrencyDomainModel model) async {
    await this._databaseBaseConnection.transaction((txn) async {
      if (!model.isNew) {
        txn.update(_tableName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
      } else {
        txn.insert(_tableName, model.toMap());
      }
    });
  }

  @override
  Future<void> delete(String id) async {
    await this._databaseBaseConnection.transaction((DataBaseTransaction txn) async {
      txn.delete(_tableName, id);
    });
  }

  @override
  Future<List<CurrencyListReadModel>> fetchCurrencyList() async {
    List<CurrencyListReadModel> result = [];
    await _databaseBaseConnection.transaction((DataBaseTransaction txn) async {
      List<Map<String, dynamic>> list = await txn.select(_tableName);
      list.forEach((Map<String, dynamic> data) {
        result.add(CurrencyListReadModel(
          id: data['id'].toString(),
          symbol: data['symbol'].toString(),
          name: data['name'].toString(),
          avatarColor: data['color'],
          isDefault: data['isDefault'],
        ));
      });
    });
    return result;
  }

  @override
  Future<CurrencyDetailReadModel> getCurrencyFromId(String id) async {
    CurrencyDetailReadModel result;
    await this._databaseBaseConnection.transaction((txn) async {
      List<Map<String, dynamic>> queryResult = await txn.select(_tableName, where: 'id = ?', whereArgs: [id]);
      if (queryResult.isNotEmpty) result = CurrencyDetailReadModel.fromMap(queryResult.first);
    });
    return result;
  }

  /*Future<bool> _currencyNotExist(String id, DataBaseTransaction txn) async {
    List<Map<String, dynamic>> list = await txn.select(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
    return list.isEmpty;
  }*/

  @override
  Future<bool> currencyIsExist(String id) async {
    bool exists = false;
    await this._databaseBaseConnection.transaction((txn) async {
      List<Map<String, dynamic>> list = await txn.select(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
      exists = list.isNotEmpty;
    });
    return exists;
  }
}
