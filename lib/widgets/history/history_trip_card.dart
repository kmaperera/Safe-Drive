import 'package:flutter/material.dart';
import 'package:safe_drive/widgets/history/section_card.dart';
import 'package:safe_drive/widgets/history/status_chip.dart';



class HistoryTripCard extends StatelessWidget {
  const HistoryTripCard({
    super.key,
    required this.date,
    required this.duration,
    required this.alerts,
    required this.status,
    required this.statusColor,
    required this.surfaceColor,
    required this.textColor,
  });

  final String date;
  final String duration;
  final String alerts;
  final String status;
  final Color statusColor;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: SectionCard(
        surfaceColor: surfaceColor,
        borderRadius: 12,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Duration: $duration   •   $alerts alerts',
                  style: TextStyle(color: textColor, fontSize: 13),
                ),
              ],
            ),
            StatusChip(label: status, color: statusColor),
          ],
        ),
      ),
    );
  }
}
