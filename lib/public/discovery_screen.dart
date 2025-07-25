import 'package:flutter/material.dart';
import 'form_screen.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  String? selectedOption;

  final List<String> options = [
    "Social Media",
    "Saw a poster",
    "Friend referred me",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("How did you hear about us?")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Please select one:", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ...options.map((option) {
              return RadioListTile(
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                  });
                },
              );
            }).toList(),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedOption == null
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FormScreen(discoverySource: selectedOption!),
                  ),
                );
              },
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
