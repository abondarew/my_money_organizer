import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/base_connection.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/memory.dart';
import 'package:mymoneyorganizer/app/infrastructure/repository/implementation/database/connection/sqlite.dart';
import 'package:mymoneyorganizer/environment.dart';

class DatabaseConnectionContainer {
  static DatabaseBaseConnection getConnection() {
    if (Environment.dataBaseType == DataBaseType.SQLITE) {
      return DatabaseConnectionSqlite.getInstance();
    } else {
      return DataBaseConnectionMemory.getInstance();
    }
  }
}
