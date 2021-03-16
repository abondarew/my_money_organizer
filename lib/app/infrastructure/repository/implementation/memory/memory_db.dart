class MemoryDb{
  Map<String, Map<String, Map<String, dynamic>>> _memoryDB; //Table<Id<Data>>
  static MemoryDb _instance;

  MemoryDb._();

  factory MemoryDb.getInstance(){
    if(_instance == null){
      _instance = MemoryDb._();
      _instance._inflateData();
    }
    return _instance;
  }

  void _inflateData(){
    _memoryDB = {
      'currency':{
        'UAH':{
          'name':'hrivna'
        },
        'USD':{
          'name':'US Dollar'
        }
      }
    };
  }
}