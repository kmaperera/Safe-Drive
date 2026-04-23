import 'package:flutter/material.dart';
import '../widgets/dashboard/driver_status_card.dart';
import '../widgets/dashboard/start_button.dart';
import '../widgets/dashboard/stats_section.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Good Evening, Driver",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              DriverStatusCard(),

              SizedBox(height: 20),

              StartButton(),

              SizedBox(height: 25),

              StatsSection(),
            ],
          ),
        ),
      ),
    );
  }
}