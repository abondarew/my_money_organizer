import 'package:mymoneyorganizer/app/core/common/model/domain/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class UsesCurrencyRepository{
  DatabaseBaseConnection _databaseBaseConnection;
  final String _tableName = 'uses_currency';

  UsesCurrencyRepository(this._databaseBaseConnection);

  Future<void> save(UsesCurrencyDomainModel model)async {
    _databaseBaseConnection.transaction((transaction) async{
      transaction.insert(_tableName, model.toMap());
    });
  }

  Future<void> delete(UsesCurrencyDomainModel model)async {
    _databaseBaseConnection.transaction((transaction) async{
      transaction.delete(_tableName, model.toMap());
    });
  }
}