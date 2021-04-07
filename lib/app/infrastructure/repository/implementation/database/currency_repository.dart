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
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CurrencyListReadModel>> fetchCurrencyList() async {
    List<CurrencyListReadModel> result = [];
    await _databaseBaseConnection.transaction((DataBaseTransaction txn) async {
      List<Map<String, dynamic>> list = await txn.select(_tableName);
      list.forEach((Map<String, dynamic> data) {
        result.add(CurrencyListReadModel(id: data['id'].toString(), symbol: data['symbol'].toString(), name: data['name'].toString()));
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
    //print('exist repo start');
    //print('1');
    //print ('exist repo aw0');
    await this._databaseBaseConnection.transaction((txn) async {
      //print('exist repo aw1');
      //print('2');
      List<Map<String, dynamic>> list = await txn.select(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
      //print('exist repo aw2');
      //print('3');
      exists = list.isNotEmpty;
      //print('4');
    });
    //print('5');
    //print ('e = $exists');
    //print('exist repo end');
    return exists;
  }
}
