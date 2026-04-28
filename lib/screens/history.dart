import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/history/history_trip_card.dart';
import '../widgets/history/section_card.dart';
import '../widgets/history/section_header.dart';
import '../widgets/history/stat_value_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Static accent colors
    const Color accentYellow = Color(0xFFFFD60A);
    const Color accentGreen = Color(0xFF32D74B);
    const Color accentBlue = Color(0xFF64B5F6);
    const Color accentRed = Color(0xFFFF453A);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme),
              const SizedBox(height: 32),
              _buildSummaryCard(accentYellow, accentGreen),
              const SizedBox(height: 24),
              _buildLineChartCard(theme, accentBlue, isDark),
              const SizedBox(height: 24),
              _buildBarChartCard(theme, accentYellow, isDark),
              const SizedBox(height: 32),
              Text(
                'Recent Trips',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // NOTICE: We removed surfaceColor and textColor here
              const HistoryTripCard(
                date: 'Today, 2:30 PM',
                duration: '2h 15m',
                alerts: '3',
                status: 'Moderate',
                statusColor: accentYellow,
              ),
              const HistoryTripCard(
                date: 'Yesterday, 8:00 AM',
                duration: '1h 45m',
                alerts: '1',
                status: 'Good',
                statusColor: accentGreen,
              ),
              const HistoryTripCard(
                date: 'Feb 26, 6:00 PM',
                duration: '3h 30m',
                alerts: '7',
                status: 'High',
                statusColor: accentRed,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History & Analytics',
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your fatigue patterns',
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Color accentYellow, Color accentGreen) {
    return SectionCard(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            icon: Icons.calendar_today_outlined,
            title: 'This Week Summary',
            accentColor: Color(0xFF32D74B),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: StatValueTile(label: 'Total Trips', value: '24')),
              Expanded(child: StatValueTile(label: 'Total Alerts', value: '24', valueColor: accentYellow)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: StatValueTile(label: 'Driving Time', value: '42h')),
              Expanded(child: StatValueTile(label: 'Avg Fatigue', value: '28%', valueColor: accentGreen)),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widgets for Charts (Line and Bar)
  Widget _buildLineChartCard(ThemeData theme, Color accentBlue, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_down, color: accentBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Fatigue Levels Today',
                style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 180,
            child: LineChart(LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [const FlSpot(0, 20), const FlSpot(4, 55), const FlSpot(12, 20)],
                  isCurved: true,
                  color: accentBlue,
                  barWidth: 3,
                  dotData: const FlDotData(show: false),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartCard(ThemeData theme, Color accentYellow, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Alert Summary',
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 160,
            child: BarChart(BarChartData(
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: accentYellow, width: 16)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 8, color: accentYellow, width: 16)]),
              ],
            )),
          ),
        ],
      ),
    );
  }
}