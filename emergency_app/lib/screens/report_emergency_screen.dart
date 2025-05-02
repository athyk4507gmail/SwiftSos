import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ReportEmergencyScreen extends StatefulWidget {
  const ReportEmergencyScreen({super.key});

  @override
  State<ReportEmergencyScreen> createState() => _ReportEmergencyScreenState();
}

class _ReportEmergencyScreenState extends State<ReportEmergencyScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = ['Fire', 'Accident', 'Robbery', 'Medical', 'Other'];

  void _submitAlert() async {
    final message = _messageController.text.trim();
    final category = _selectedCategory;

    if (message.isEmpty || category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message and select a category')),
      );
      return;
    }

    final success = await ApiService.sendAlert(message, category);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Emergency reported!')),
      );
      _messageController.clear();
      setState(() => _selectedCategory = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send alert')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Emergency')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Describe the emergency'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Emergency Type',
                border: OutlineInputBorder(),
              ),
              value: _selectedCategory,
              items: _categories
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAlert,
              child: const Text('Send Alert'),
            ),
          ],
        ),
      ),
    );
  }
}