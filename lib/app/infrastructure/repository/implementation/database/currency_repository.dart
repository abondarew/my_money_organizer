import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class CurrencyDatabaseRepository implements CurrencyBaseRepository {
  DatabaseBaseConnection _databaseBaseConnection;
  final String _tableName = 'uses_currency';

  CurrencyDatabaseRepository(this._databaseBaseConnection);

  Future<void> save(UsesCurrencyDomainModel model) async {
    await this._databaseBaseConnection.transaction((txn) async {
      //print(model.isNew);
      if (!model.isNew) {
        //await _currencyExist(model.id, txn)) {
        txn.update(_tableName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
      } else {
        //if (await _currencyNotExist(model.id, txn)) {
        txn.insert(_tableName, model.toMap());
        /*}else{
          print('error save!');
        }*/
      }
    });
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UsesCurrencyListReadModel>> fetchCurrencyList() async {
    List<UsesCurrencyListReadModel> result = [];
    await _databaseBaseConnection.transaction((DataBaseTransaction txn) async {
      List<Map<String, dynamic>> list = await txn.select(_tableName);
      list.forEach((Map<String, dynamic> data) {
        result.add(UsesCurrencyListReadModel(id: data['id'], symbol: data['symbol'], name: data['name']));
      });
    });
    return result;
  }

  @override
  Future<UsesCurrencyDetailReadModel> getCurrencyFromId(String id) async {
    UsesCurrencyDetailReadModel result;
    await this._databaseBaseConnection.transaction((txn) async {
      List<Map<String, dynamic>> queryResult = await txn.select(_tableName, where: 'id = ?', whereArgs: [id]);
      if (queryResult.isNotEmpty) result = UsesCurrencyDetailReadModel.fromMap(queryResult.first);
    });
    return result;
  }

  Future<bool> _currencyNotExist(String id, DataBaseTransaction txn) async {
    List<Map<String, dynamic>> list = await txn.select(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
    return list.isEmpty;
  }

  @override
  Future<bool> currencyNotExist(String id) async {
    bool exists = false;
    //print('1');
    await this._databaseBaseConnection.transaction((txn) async {
      //print('2');
      List<Map<String, dynamic>> list = await txn.select(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
      //print('3');
      exists = list.isNotEmpty;
      //print('4');
    });
    //print('5');
    //print ('e = $exists');
    return exists;
  }
}
