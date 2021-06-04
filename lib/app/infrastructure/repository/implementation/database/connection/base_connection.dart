abstract class DatabaseBaseConnection {
  Future<void> transaction(Future<void> Function(DataBaseTransaction txn) action);
}

abstract class DataBaseTransaction {
  ///
  /// Insert query
  ///
  Future<void> insert(String table, Map<String, dynamic> data);

  ///
  /// Update query
  ///
  Future<void> update(String table, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs});

  ///
  /// Select query
  ///
  Future<List<Map<String, dynamic>>> select(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });

  Future<void> delete(String table, String id);
}
