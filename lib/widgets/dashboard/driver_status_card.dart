import 'package:flutter/material.dart';
import 'package:safe_drive/widgets/dashboard/status_indicator.dart';
import 'dashboard_card.dart';

class DriverStatusCard extends StatelessWidget {
  const DriverStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT SIDE (text only)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Driver Status",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                "Safe",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // RIGHT SIDE (ring + inner circle)
          const StatusIndicator(),
        ],
      ),
    );
  }
}