class Environment {
  static bool? debug = false;
  static DataBaseType? dataBaseType = DataBaseType.SQLITE;

  static void init({bool? debug, DataBaseType? dataBaseType}) {
    Environment.debug = debug;
    Environment.dataBaseType = dataBaseType;
  }
}

enum DataBaseType { SQLITE, MEMORY }
