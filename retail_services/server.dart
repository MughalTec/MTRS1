import 'dart:io';
import 'database_connection.dart';
void main() async{
  var server =await HttpServer.bind(InternetAddress.anyIPv4,80);
  print('Server running on port 80');
  var connection = await DatabaseConnection.getConnection();
  await for (HttpRequest request in server){
    var result = await connection.query(
    'SELECT * FROM mtrs."tblCompaney"'
    );
    request.response
    ..write(result.toString())
    ..close();
  }
}