// Import database connection file
import 'database_connection.dart';

// This class handles getting company data from database
class CompanyService {

  // Function to fetch companies
  static Future<List<Map<String, dynamic>>> getCompanies() async {

    try {

      // Get database connection
      final conn = await DatabaseConnection.getConnection();

      // SQL Query — now fetching ALL real fields
      final results = await conn.query(
          '''
        SELECT 
        "CompanyName",
        "BillingAddress",
        "City",
        "State",
        "Zipcode",
        "Country"
        FROM mtrs."tblCompaney"
        '''
      );

      // Convert database rows into usable list
      return results.map((row) {

        return {
          "name": row[0],
          "address": row[1],
          "city": row[2],
          "state": row[3],
          "zipcode": row[4],
          "country": row[5],
        };

      }).toList();

    }

    catch (e) {

      // If database fails — fallback demo data
      print("Database failed: $e");

      return [

        {
          "name": "Tech Store Ltd",
          "address": "Street 12",
          "city": "Tallinn",
          "state": "Harju",
          "zipcode": "10115",
          "country": "Estonia",
        },

        {
          "name": "Retail Hub OÜ",
          "address": "Main Road 5",
          "city": "Tartu",
          "state": "Tartu",
          "zipcode": "50090",
          "country": "Estonia",
        },

        {
          "name": "Market Solutions",
          "address": "Central Ave 9",
          "city": "Narva",
          "state": "Ida-Viru",
          "zipcode": "20304",
          "country": "Estonia",
        },

      ];
    }
  }
}