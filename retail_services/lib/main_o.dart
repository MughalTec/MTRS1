// Import Flutter UI package
import 'package:flutter/material.dart';

// Import service file that fetches data from database
import 'company_service.dart';

// App starting point
void main() {
  runApp(const RetailApp());
}

// Main App Widget
class RetailApp extends StatelessWidget {
  const RetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // App title
      title: 'MTRS1 Retail Services',

      // Remove debug banner
      debugShowCheckedModeBanner: false,

      // Theme settings (Estonia colors)
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        // Top bar style
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0072CE), // Estonia blue
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        // Color theme
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0072CE),
          secondary: Colors.black,
        ),

        // Card styling
        cardTheme: const CardThemeData(
          elevation: 5,
          margin: EdgeInsets.all(8),
        ),
      ),

      // First screen
      home: const HomeScreen(),
    );
  }
}

// ================= HOME SCREEN =================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Stores company list
  List companies = [];

  // Shows loading spinner
  bool loading = true;

  // Runs when screen opens
  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Fetch data from database
  Future<void> loadData() async {

    // Calls CompanyService
    final data = await CompanyService.getCompanies();

    // Update UI
    setState(() {
      companies = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Top bar
      appBar: AppBar(
        title: const Text('MTRS1 Companies'),

        // About button
        actions: [
          IconButton(
            icon: const Icon(Icons.info),

            // Open About screen
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // Screen body
      body: loading

      // Loading spinner
          ? const Center(
        child: CircularProgressIndicator(),
      )

      // Company list
          : ListView.builder(

        padding: const EdgeInsets.all(12),

        itemCount: companies.length,

        itemBuilder: (context, index) {

          final c = companies[index];

          return Card(

            child: ListTile(

              // Left icon
              leading: const Icon(
                Icons.business,
                color: Colors.blue,
              ),

              // Company name
              title: Text(
                c["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Company city
              subtitle: Text(c["city"]),

              // Arrow icon
              trailing: const Icon(Icons.arrow_forward),

              // Open detail page
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(company: c),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= DETAIL SCREEN =================

class DetailScreen extends StatelessWidget {

  // Receives selected company
  final Map company;

  const DetailScreen({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Company Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Card(

          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // Company Name
                Text(
                  company["name"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Address
                Text(
                    "Address: ${company["address"]}"
                ),

                const SizedBox(height: 8),

                // City
                Text(
                    "City: ${company["city"]}"
                ),

                const SizedBox(height: 8),

                // State
                Text(
                    "State: ${company["state"]}"
                ),

                const SizedBox(height: 8),

                // Zipcode
                Text(
                    "Zipcode: ${company["zipcode"]}"
                ),

                const SizedBox(height: 8),

                // Country
                Text(
                    "Country: ${company["country"]}"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ABOUT SCREEN =================

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("About MTRS1"),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16),

        child: Card(

          child: Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              "MTRS1 Retail Services Demo\n\n"
                  "This application displays company data "
                  "from the retail services system.\n\n"
                  "Built using Flutter for Web and Android.",

              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}