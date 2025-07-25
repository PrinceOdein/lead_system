import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> selectedServices = [];

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  Map<String, int> getLeadsPerDay(List<QueryDocumentSnapshot> docs) {
    final Map<String, int> leadCounts = {};
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final timestamp = data['timestamp'] as Timestamp?;
      if (timestamp != null) {
        final date = timestamp.toDate();
        final key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        leadCounts[key] = (leadCounts[key] ?? 0) + 1;
      }
    }
    return leadCounts;
  }

  Map<String, int> getServiceDistribution(List<QueryDocumentSnapshot> docs) {
    final Map<String, int> serviceCounts = {};
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final services = data['services'] as List<dynamic>? ?? [];
      for (var service in services) {
        serviceCounts[service] = (serviceCounts[service] ?? 0) + 1;
      }
    }
    return serviceCounts;
  }

  List<BarChartGroupData> buildBarChartGroups(Map<String, int> leadCounts) {
    final sortedKeys = leadCounts.keys.toList()..sort();
    return List.generate(sortedKeys.length, (index) {
      final key = sortedKeys[index];
      final count = leadCounts[key]!;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            color: Colors.blue,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<PieChartSectionData> buildPieChartSections(Map<String, int> serviceCounts) {
    final total = serviceCounts.values.fold(0, (a, b) => a + b);
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple];
    return List.generate(serviceCounts.length, (index) {
      final key = serviceCounts.keys.elementAt(index);
      final value = serviceCounts[key]!;
      final percentage = (value / total) * 100;
      return PieChartSectionData(
        color: colors[index % colors.length],
        value: value.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        badgeWidget: Text(key, style: const TextStyle(fontSize: 10)),
        badgePositionPercentageOffset: 1.2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              children: [
                "Real Estate",
                "Car Hire/Lease",
                "Logistics",
                "Solar Installation",
                "CCTV Installation"
              ].map((service) {
                return FilterChip(
                  label: Text(service),
                  selected: selectedServices.contains(service),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedServices.add(service);
                      } else {
                        selectedServices.remove(service);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (selectedServices.isEmpty)
                    ? FirebaseFirestore.instance.collection('leads').orderBy('timestamp', descending: true).snapshots()
                    : FirebaseFirestore.instance
                    .collection('leads')
                    .where('services', arrayContainsAny: selectedServices)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                  final leads = snapshot.data!.docs;
                  if (leads.isEmpty) return const Center(child: Text("No leads found."));

                  final leadCounts = getLeadsPerDay(leads);
                  final serviceCounts = getServiceDistribution(leads);

                  return ListView(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            barGroups: buildBarChartGroups(leadCounts),
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: buildPieChartSections(serviceCounts),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...leads.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final fullName = data['fullName'] ?? 'No Name';
                        final phoneNumber = data['phoneNumber'] ?? 'No Number';
                        final services = data['services'] as List<dynamic>? ?? [];
                        final formattedServices = services.join(', ');
                        final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
                        final dateStr = timestamp != null
                            ? "${timestamp.day}/${timestamp.month}/${timestamp.year}"
                            : "Unknown Date";

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(fullName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone: $phoneNumber"),
                                Text("Services: $formattedServices"),
                                Text("Date: $dateStr"),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
