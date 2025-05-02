import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EmergencyApp());
}

class EmergencyApp extends StatelessWidget {
  const EmergencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Alert System',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
