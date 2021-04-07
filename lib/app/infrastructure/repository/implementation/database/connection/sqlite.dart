import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';
import 'package:sqflite/sqflite.dart' as SQFLite;

class DatabaseConnectionSqlite extends DatabaseBaseConnection {
  static DatabaseConnectionSqlite _instance;
  SQFLite.Database _db;
  final int _version = 1;
  final String _patch = 'mmo';

  DatabaseConnectionSqlite._();

  factory DatabaseConnectionSqlite.getInstance() {
    if (_instance == null) {
      _instance = DatabaseConnectionSqlite._();
    }
    return _instance;
  }

  Future<SQFLite.Database> _getDB() async {
    if (_db == null) {
      _db = await SQFLite.openDatabase(_patch, onCreate: _onCreateDB, version: _version);
    }
    return _db;
  }

  Future<void> _onCreateDB(SQFLite.Database db, int version) async {
    await db.execute('CREATE TABLE uses_currency (id STRING PRIMARY KEY NOT NULL, name STRING, symbol STRING, fraction INTEGER)');
  }

  @override
  Future<void> transaction(Future<void> Function(DataBaseTransaction txn) action) async {
    SQFLite.Database _db = await this._getDB();
    await _db.transaction((txn) async {
      await action(new DataBaseTransactionSqlite(txn));
    });
  }
}

class DataBaseTransactionSqlite implements DataBaseTransaction {
  SQFLite.DatabaseExecutor _executor;

  DataBaseTransactionSqlite(this._executor);

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    this._executor.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> select(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) async {
    return await this._executor.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data, {String where, List whereArgs}) async {
    await this._executor.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> delete(String table, Map<String, dynamic> data) async {
    await this._executor.delete(table, where: 'id = ?', whereArgs: data['id']);
  }
}
