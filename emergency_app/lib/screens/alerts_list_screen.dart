import 'package:flutter/material.dart';

class AlertsListScreen extends StatelessWidget {
  const AlertsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of alerts
    final List<String> alerts = [
      'Accident on Highway 45',
      'Robbery reported near Market Street',
      'Vehicle breakdown reported near Exit 12',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Active Alerts')),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(alerts[index]),
          );
        },
      ),
    );
  }
}
