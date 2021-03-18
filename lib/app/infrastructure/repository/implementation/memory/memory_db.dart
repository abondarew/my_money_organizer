class MemoryDb {
  Map<String, Map<String, Map<String, dynamic>>> _memoryDB; //Table<Id<Data>>
  static MemoryDb _instance;

  MemoryDb._();

  factory MemoryDb.getInstance() {
    if (_instance == null) {
      _instance = MemoryDb._();
      _instance._inflateData();
    }
    return _instance;
  }

  void _inflateData() {
    _memoryDB = {
      'uses_currency': {
        'UAH': {'name': 'hrivna'},
        'USD': {'name': 'US Dollar'}
      }
    };
  }

  Future<void> transaction(Future<void> Function(MemoryDbExecutor txn) action) async {
    MemoryDbExecutor txn = MemoryDbExecutor();
    action(txn);
  }

  void insert(String table, Map<String, dynamic> data) {
    _memoryDB[table][data['id']] = data;
  }
}

class MemoryDbExecutor {
  Future<void> insert(String table, Map<String, dynamic> data) async {
    MemoryDb db = MemoryDb.getInstance();
    db.insert(table, data);
  }

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

  Future<void> update(String table, Map<String, dynamic> data, {String where, List<dynamic> whereArgs}) {
    // TODO: implement update
    throw UnimplementedError();
  }
/*  Future<void> insert(String table, Map<String, dynamic> data);
  Future<void> update(String table, Map<String, dynamic> data);
  Future<void> delete(String table, Map<String, dynamic> data);
  Future<Map<String, dynamic>> query(String table);*/
}
