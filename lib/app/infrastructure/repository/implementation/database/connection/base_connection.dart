import 'package:sqflite/sqlite_api.dart';

abstract class DatabaseBaseConnection {
  Future<void> transaction(Future<void> Function(DataBaseTransaction transaction) action);

  // Future<void> insert(String table, Map<String, dynamic> data);
  //
  // Future<void> update(String table, Map<String, dynamic> data);
  //
  // Future<void> delete(String table, Map<String, dynamic> data);
  //
  // Future<List<Map<String, dynamic>>> select(String table, {String where, List<dynamic> whereArg, List<String> columns});
}

abstract class DataBaseTransaction{
  // Transaction _transaction;
  ///
  /// Insert query
  ///
  Future<void> insert(String table, Map<String, dynamic> data);

  ///
  /// Update query
  ///
  Future<void> update(String table, Map<String, dynamic> data, {String where, List<dynamic> whereArgs});

  ///
  /// Select query
  ///
  Future<List<Map<String, dynamic>>> select(
      String table, {
        bool distinct,
        List<String> columns,
        String where,
        List<dynamic> whereArgs,
        String groupBy,
        String having,
        String orderBy,
        int limit,
        int offset,
      });

  Future<void> delete(String table, Map<String, dynamic> data);
}