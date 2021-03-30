import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/repository/base_repository.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class CurrencyDatabaseRepository implements CurrencyBaseRepository{
  DatabaseBaseConnection _databaseBaseConnection;
  final String _tableName = 'uses_currency';

  CurrencyDatabaseRepository(this._databaseBaseConnection);

  Future<void> save(UsesCurrencyDomainModel model)async {
    _databaseBaseConnection.transaction((transaction) async{
      transaction.insert(_tableName, model.toMap());
    });
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UsesCurrencyReadModel>> fetchCurrencyList() async{
    /*// TODO: implement fetchCurrencyList
    throw UnimplementedError();*/
    List<UsesCurrencyReadModel> result = [];
    await _databaseBaseConnection.transaction((DataBaseTransaction transaction) async {
      List<Map<String, dynamic>> list =  await transaction.select(_tableName);
      list.forEach((Map<String, dynamic> data) {
        result.add(UsesCurrencyReadModel(id: data['id'], symbol: data['symbol'], name: data['name']));
      });

    });
    return result;
  }

  @override
  Future<UsesCurrencyReadModel> getCurrencyFromId(String id) {
    // TODO: implement getCurrencyFromId
    throw UnimplementedError();
  }
}