import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import 'live_feed_screen.dart';
import 'map_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<String> _emergencyTypes = [
    'Fire',
    'Medical',
    'Crime',
    'Natural Disaster',
    'Other',
  ];
  String _selectedType = 'Fire';

  Future<void> _showAccidentalBufferAndSendAlert() async {
    final player = AudioPlayer();
    int countdown = 10;
    const int totalTime = 10;
    Timer? timer;

    await player.play(AssetSource('buzzer.mp3'), volume: 1.0);

    bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (countdown == 1) {
                player.stop();
                Navigator.of(context).pop(true);
                t.cancel();
              } else {
                setState(() => countdown--);
              }
            });

            double progress = countdown / totalTime;

            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text(
                'Confirm Emergency Alert',
                style: TextStyle(color: Colors.redAccent),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Text(
                        '$countdown',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      timer?.cancel();
                      player.stop();
                      Navigator.of(context).pop(false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancel Alert'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    timer?.cancel();
    await player.stop();

    if (confirmed == true) {
      final success = await ApiService.sendAlert(
        message: _messageController.text,
        emergencyType: _selectedType,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alert sent successfully!')),
        );
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send alert.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alert cancelled.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            child: const RiveAnimation.asset(
              'assets/rive/particles.riv',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: Colors.cyanAccent,
                    highlightColor: Colors.blueAccent,
                    child: Text(
                      'SwiftSoS',
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildGlassCard(
                    child: DropdownButtonFormField<String>(
                      value: _selectedType,
                      items: _emergencyTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedType = value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Select Emergency Type',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildGlassCard(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your emergency message',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNeonButton(
                    onPressed: _showAccidentalBufferAndSendAlert,
                    text: 'Send SOS Alert',
                    color: Colors.redAccent,
                    glowColor: Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  _buildNeonButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LiveFeedScreen(),
                        ),
                      );
                    },
                    text: 'View Live Alerts',
                    color: Colors.cyanAccent,
                    glowColor: Colors.cyanAccent,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  _buildNeonButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(),
                        ),
                      );
                    },
                    text: 'View My Location',
                    color: Colors.blueAccent,
                    glowColor: Colors.lightBlueAccent,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildNeonButton({
    required VoidCallback onPressed,
    required String text,
    required Color color,
    required Color glowColor,
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.7),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}




















