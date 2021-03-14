import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnectionSqlite extends DatabaseBaseConnection {
  static DatabaseConnectionSqlite _instance;
  Database _db;
  final int _version = 1;
  final String _patch = 'mmo';

  @override
  Future<void> transaction() {
    // TODO: implement transaction
    throw UnimplementedError();
  }

  DatabaseConnectionSqlite._();

  factory DatabaseConnectionSqlite.getInstance() {
    if (_instance == null) {
      _instance = DatabaseConnectionSqlite._();
    }
    return _instance;
  }

  Future<Database> _getDB() async {
    if (_db == null) {
      _db = await openDatabase(_patch, onCreate: _onCreateDB, version: _version);
    }
    return _db;
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE uses_currency (id STRING PRIMARY KEY NOT NULL, name STRING, symbol STRING, fraction INTEGER)');
  }

  @override
  Future<void> delete(String table, Map<String,dynamic> data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    Database db = await _getDB();
    await db.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> select(String table,
      {String where,
      List whereArg,
      List<String> columns,
      bool distinct,
      String groupBy,
      String orderBy,
      String having,
      int limit,
      int offset}) async {
    Database db = await _getDB();
    return db.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArg,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  @override
  Future<void> update(String table, Map<String,dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
