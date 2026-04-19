import 'package:postgres/postgres.dart';
class DatabaseConnection {
  static PostgreSQLConnection?_connection;
  static Future<PostgreSQLConnection>getConnection() async{
    if(_connection!=null) {
      return _connection!;
    }
    _connection=PostgreSQLConnection(
            'remotedev.mughaltec.com',
              5432,
              'MTRS',
          username:'postgres',
          password:'super',
          );
    await _connection!.open();

    return _connection!;
  }
}