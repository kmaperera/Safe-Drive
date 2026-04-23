import 'package:flutter/material.dart';
import 'stat_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Today's Statistics",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 15),

        // CARD 1
        StatCard(
          icon: Icons.timer,
          title: "Today's Driving Time",
          value: "4h 32m",
          iconBgColor: Color(0xFF1E3A2F), // dark green bg
          iconColor: Colors.green,
        ),

        // CARD 2
        StatCard(
          icon: Icons.warning_amber_rounded,
          title: "Fatigue Alerts Count",
          value: "3",
          iconBgColor: Color(0xFF3A2F1E), // dark yellow bg
          iconColor: Colors.amber,
        ),

        // CARD 3
        StatCard(
          icon: Icons.access_time,
          title: "Last Trip Duration",
          value: "2h 15m",
          iconBgColor: Color(0xFF1E2A3A), // dark blue bg
          iconColor: Colors.blue,
        ),
      ],
    );
  }
}