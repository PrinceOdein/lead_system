import 'package:flutter/material.dart';
import 'form_screen.dart';

class HomeScreen extends StatelessWidget {
  final String discoverySource;
  HomeScreen({required this.discoverySource});

  final List<String> services = [
    'Real Estate',
    'Car Hire/Leasing',
    'Logistics',
    'Solar Installation',
    'CCTV Installation'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Service")),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(services[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormScreen(
                    service: services[index],
                    discoverySource: discoverySource,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
