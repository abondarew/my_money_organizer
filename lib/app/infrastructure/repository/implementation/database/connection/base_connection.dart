abstract class DatabaseBaseConnection {
  Future<void> transaction();

  Future<void> insert(String table, Map<String, dynamic> data);

  Future<void> update(String table, Map<String, dynamic> data);

  Future<void> delete(String table, Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> select(String table, {String where, List<dynamic> whereArg, List<String> columns});
}
