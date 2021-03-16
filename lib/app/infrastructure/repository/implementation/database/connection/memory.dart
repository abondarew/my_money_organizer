import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';

class DataBaseConnectionMemory extends DatabaseBaseConnection {
  static DataBaseConnectionMemory _instance;

  DataBaseConnectionMemory._();

  factory DataBaseConnectionMemory.getInstance() {
    _instance ??= DataBaseConnectionMemory._();
    return _instance;
  }

  @override
  Future<void> transaction(
      Future<void> Function(DataBaseTransaction transaction) action) {
    // TODO: implement transaction
    throw UnimplementedError();
  }
// @override
// Future<void> transaction() {
//   // TODO: implement transaction
//   throw UnimplementedError();
// }
//
// DataBaseConnectionMemory._();
//
// factory DataBaseConnectionMemory.getInstance(){
//   if(_instance == null){
//     _instance = DataBaseConnectionMemory._();
//   }
//   return _instance;
// }
//
// @override
// Future<void> delete(String table, Map<String, dynamic> data) {
//   // TODO: implement delete
//   throw UnimplementedError();
// }
//
// @override
// Future<void> insert(String table, Map<String,dynamic> data) {
//   // TODO: implement insert
//   throw UnimplementedError();
// }
//
// @override
// Future<List<Map<String, dynamic>>> select(String table, {String where, List whereArg, List<String> columns}) {
//   // TODO: implement select
//   throw UnimplementedError();
// }
//
// @override
// Future<void> update(String table, Map<String, dynamic> data) {
//   // TODO: implement update
//   throw UnimplementedError();
// }
}

class DataBaseTransactionMemory implements DataBaseTransaction {
  @override
  Future<void> insert(String table, Map<String, dynamic> data) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> select(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data,
      {String where, List<dynamic> whereArgs}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
