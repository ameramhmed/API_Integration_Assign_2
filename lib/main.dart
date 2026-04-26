import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: CountryScreen()),
);

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  Map<String, dynamic>? countryData;
  bool isLoading = true;

  Future<void> fetchCountryData() async {
    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/name/palestine'),
      );
      if (response.statusCode == 200) {
        setState(() {
          countryData = json.decode(response.body)[0];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("API Integration Assignment"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // مؤشر التحميل
            : Card(
                elevation: 8,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // عرض علم الدولة
                      Image.network(countryData!['flags']['png'], height: 100),
                      const SizedBox(height: 20),
                      Text(
                        countryData!['name']['common'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        "Capital: ${countryData!['capital'][0]}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Region: ${countryData!['region']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Population: ${countryData!['population']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
