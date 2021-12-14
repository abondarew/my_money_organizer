class Environment {
  static bool debug = false;
  static DataBaseType dataBaseType = DataBaseType.SQLITE;

  static void init({bool debug = false, DataBaseType dataBaseType = DataBaseType.SQLITE}) {
    Environment.debug = debug;
    Environment.dataBaseType = dataBaseType;
  }
}

enum DataBaseType { SQLITE, MEMORY }
