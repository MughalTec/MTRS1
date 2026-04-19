import 'package:flutter/material.dart';

void main() {
  runApp(const RetailApp());
}

class RetailApp extends StatelessWidget {
  const RetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retail Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retail Services'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Shirt'),
            subtitle: Text('Price: 100'),
          ),
          ListTile(
            title: Text('Shoes'),
            subtitle: Text('Price: 200'),
          ),
          ListTile(
            title: Text('Bag'),
            subtitle: Text('Price: 150'),
          ),
        ],
      ),
    );
  }
}