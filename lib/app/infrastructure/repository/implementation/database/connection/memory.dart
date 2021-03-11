import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class DataBaseConnectionMemory extends DatabaseBaseConnection{
  static DataBaseConnectionMemory _instance;
  @override
  Future<void> transaction() {
    // TODO: implement transaction
    throw UnimplementedError();
  }

  DataBaseConnectionMemory._();

  factory DataBaseConnectionMemory.getInstance(){
    if(_instance == null){
      _instance = DataBaseConnectionMemory._();
    }
    return _instance;
  }
}