import 'database_connection.dart';

class CompanyService {
  static Future<List<Map<String, dynamic>>> getCompanies() async {
    try {
      final conn = await DatabaseConnection.getConnection();

      final results = await conn.query(
          '''
        SELECT "CompanyName", "BillingAddress", "City", "Country"
        FROM mtrs."tblCompaney"
        '''
      );

      return results.map((row) {
        return {
          "name": row[0],
          "address": row[1],
          "city": row[2],
          "country": row[3],
        };
      }).toList();

    } catch (e) {
      print("Database failed: $e");

      // SAFE DEMO DATA
      return [
        {
          "name": "Tech Store Ltd",
          "address": "Street 12",
          "city": "Tallinn",
          "country": "Estonia",
        },
        {
          "name": "Retail Hub OÜ",
          "address": "Main Road 5",
          "city": "Tartu",
          "country": "Estonia",
        },
        {
          "name": "Market Solutions",
          "address": "Central Ave 9",
          "city": "Narva",
          "country": "Estonia",
        },
      ];
    }
  }
}