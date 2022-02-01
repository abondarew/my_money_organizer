import 'dart:io';

import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';
import 'package:sqflite/sqflite.dart' as SQFLite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseConnectionSqlite extends DatabaseBaseConnection {
  static DatabaseConnectionSqlite? _instance;
  SQFLite.Database? _db;
  final int _version = 1;
  final String _patch = 'mmo';

  DatabaseConnectionSqlite._();

  factory DatabaseConnectionSqlite.getInstance() {
    _instance ??= DatabaseConnectionSqlite._();
    return _instance!;
  }

  Future<SQFLite.Database?> _getDB() async {
    if (_db == null) {
      if (Platform.isWindows || Platform.isLinux) {
        // Initialize FFI
        sqfliteFfiInit();
        // Change the default factory
        SQFLite.databaseFactory = databaseFactoryFfi;
      }
      _db = await SQFLite.openDatabase(_patch, onCreate: _onCreateDB, version: _version);
    }
    return _db!;
  }

  Future<void> _onCreateDB(SQFLite.Database db, int version) async {
    await db.execute(
        'CREATE TABLE uses_currency (id STRING PRIMARY KEY NOT NULL, name STRING, color INTEGER, symbol STRING, fraction INTEGER, isDefault INTEGER)');
  }

  @override
  Future<void> transaction(Future<void> Function(DataBaseTransaction txn) action) async {
    SQFLite.Database? _db = await _getDB();
    await _db!.transaction((txn) async {
      await action(DataBaseTransactionSqlite(txn)); //await action(new DataBaseTransactionSqlite(txn));
    });
  }
}

class DataBaseTransactionSqlite implements DataBaseTransaction {
  final SQFLite.DatabaseExecutor executor;

  DataBaseTransactionSqlite(this.executor);

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    executor.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> select(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await executor.query(table,
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
  Future<void> update(String table, Map<String, dynamic> data, {String? where, List? whereArgs}) async {
    await executor.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> delete(String table, String id) async {
    await executor.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
