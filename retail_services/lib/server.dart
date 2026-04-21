import 'dart:io';//built-in  input/output library of dart
import '../database_connection.dart';
//async=time consuming
void main() async{
  //httpServer.bind=start server and run in IP and Port
  //InternetAddress.anyIPv4=server run on every IPAddress like localhost,Wifi,network
  var server =await HttpServer.bind(InternetAddress.anyIPv4,80);
  print('Server running on port 80');
  //Take database connection and store in connection variable
  var connection = await DatabaseConnection.getConnection();
  //HttpRequest=Use to taking request
  //HttpRequest request=every request store in variable request
  //in server=run loop on every request of server
  await for (HttpRequest request in server){
    //store the data of database in variable result
    var result = await connection.query(
    'SELECT * FROM mtrs."tblCompaney";'
  );
    for (var row in result) {
      request.response //start response to browser
        .write(row.toString()+"\n"); //convert database result in text
    }
    request.response.close();//complete response

  }
}