import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: '103.127.96.16',
      port: 33306,
      user: 'root',
      password: '123',
      db: 'employes',
    );
    return await MySqlConnection.connect(settings);
  }
}
