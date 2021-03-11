import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class DatabaseConnectionSqlite extends DatabaseBaseConnection{
  static DatabaseConnectionSqlite _instance;
  @override
  Future<void> transaction() {
    // TODO: implement transaction
    throw UnimplementedError();
  }

  DatabaseConnectionSqlite._();

  factory DatabaseConnectionSqlite.getInstance(){
    if(_instance == null){
      _instance = DatabaseConnectionSqlite._();
    }
    return _instance;
  }
}