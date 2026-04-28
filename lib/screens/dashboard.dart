import 'package:flutter/material.dart';
import '../widgets/dashboard/driver_status_card.dart';
import '../widgets/dashboard/start_button.dart';
import '../widgets/dashboard/stats_section.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Good evening, driver",
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6), 
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 32),
              const DriverStatusCard(),
              const SizedBox(height: 20),
              const StartButton(),
              const SizedBox(height: 24),
              const StatsSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}