import 'package:http/http.dart';
import 'package:postgres/postgres.dart';
void main() async{
  final connection = PostgreSQLConnection(
      "remotedev.mughaltec.com",
      5432,
      "MTRS",
    username:"postgres",
      password:"",
  );
  await connection.open();
  var output = await connection.query(
    "SELECT *from mtrs.tblCompaney"
  );
}