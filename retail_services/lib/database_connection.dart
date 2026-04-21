import 'package:postgres/postgres.dart';
class DatabaseConnection {
  static PostgreSQLConnection?_connection; //connection variable which store database connection and reuse it
  //future<PostgreSqlConnection>=Return connection in future
  //getConnection=function name,Establish a connection
  static Future<PostgreSQLConnection> getConnection()
  //async=Time consuming
  async {
    if (_connection != null) {
      return _connection!;
    }
    //make a new connection and store it
    _connection = PostgreSQLConnection(
      'remotedev.mughaltec.com',
      5432,
      'MTRS',
      username: 'postgres',
      password: 'super',
    );
    // connect to database and wait until its ready
    try {
      await _connection!.open();
      print("Connected to Server");
    }
    catch (e) {
      print("Database failed: $e");
    }


    return _connection!; //return existing connection, _connection!=not null
  }
}