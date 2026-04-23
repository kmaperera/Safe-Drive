import 'package:flutter/material.dart';
import 'package:safe_drive/screens/live_monitoring.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LiveMonitoringScreen()),
        );
      },
      child: const Text("Start Monitoring", style: TextStyle(fontSize: 16)),
    );
  }
}
