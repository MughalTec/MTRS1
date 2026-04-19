import 'package:flutter/material.dart';
import 'company_service.dart';

void main() {
  runApp(const RetailApp());
}

class RetailApp extends StatelessWidget {
  const RetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTRS1 Retail Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0072CE), // Estonia blue
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0072CE), // Blue
          secondary: Colors.black,   // Black
        ),

        cardTheme: const CardThemeData(
          elevation: 5,
          margin: EdgeInsets.all(8),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List companies = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await CompanyService.getCompanies();

    setState(() {
      companies = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTRS1 Companies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final c = companies[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(
                Icons.business,
                color: Colors.blue,
              ),
              title: Text(
                c["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(c["city"]),
              trailing: const Icon(Icons.arrow_forward),
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

class DetailScreen extends StatelessWidget {
  final Map company;

  const DetailScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company["name"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Text("Address: ${company["address"]}"),
                const SizedBox(height: 8),

                Text("City: ${company["city"]}"),
                const SizedBox(height: 8),

                Text("Country: ${company["country"]}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          elevation: 5,
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