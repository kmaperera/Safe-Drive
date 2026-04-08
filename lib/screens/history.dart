import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:safe_drive/widgets/history/history_trip_card.dart';
import 'package:safe_drive/widgets/history/section_card.dart';
import 'package:safe_drive/widgets/history/section_header.dart';
import 'package:safe_drive/widgets/history/stat_value_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final Color bgColor = const Color(0xFF121212);
  final Color cardBgColor = const Color(0xFF1C1C1E);
  final Color accentYellow = const Color(0xFFFFD60A);
  final Color accentGreen = const Color(0xFF32D74B);
  final Color accentBlue = const Color(0xFF64B5F6);
  final Color accentRed = const Color(0xFFFF453A);
  final Color textGrey = const Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildSummaryCard(),
              const SizedBox(height: 24),
              _buildLineChartCard(),
              const SizedBox(height: 24),
              _buildBarChartCard(),
              const SizedBox(height: 32),
              const Text(
                'Recent Trips',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              HistoryTripCard(
                date: 'Today, 2:30 PM',
                duration: '2h 15m',
                alerts: '3',
                status: 'Moderate',
                statusColor: accentYellow,
                surfaceColor: cardBgColor,
                textColor: textGrey,
              ),
              HistoryTripCard(
                date: 'Yesterday, 8:00 AM',
                duration: '1h 45m',
                alerts: '1',
                status: 'Good',
                statusColor: accentGreen,
                surfaceColor: cardBgColor,
                textColor: textGrey,
              ),
              HistoryTripCard(
                date: 'Feb 26, 6:00 PM',
                duration: '3h 30m',
                alerts: '7',
                status: 'High',
                statusColor: accentRed,
                surfaceColor: cardBgColor,
                textColor: textGrey,
              ),
              const SizedBox(height: 80), // Bottom padding for navbar clearance
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'History & Analytics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your fatigue patterns',
          style: TextStyle(color: textGrey, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return SectionCard(
      surfaceColor: cardBgColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.calendar_today_outlined,
            title: 'This Week Summary',
            accentColor: Color(0xFF32D74B),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: StatValueTile(
                  label: 'Total Trips',
                  value: '24',
                  labelColor: textGrey,
                  valueColor: Colors.white,
                ),
              ),
              Expanded(
                child: StatValueTile(
                  label: 'Total Alerts',
                  value: '24',
                  labelColor: textGrey,
                  valueColor: accentYellow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatValueTile(
                  label: 'Driving Time',
                  value: '42h',
                  labelColor: textGrey,
                  valueColor: Colors.white,
                ),
              ),
              Expanded(
                child: StatValueTile(
                  label: 'Avg Fatigue',
                  value: '28%',
                  labelColor: textGrey,
                  valueColor: accentGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLineChartCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_down, color: accentBlue, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Fatigue Levels Today',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 15,
                  verticalInterval: 2,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: textGrey.withOpacity(0.15),
                      strokeWidth: 1,
                      dashArray: [4, 4], // Dashed line
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: textGrey.withOpacity(0.15),
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${value.toInt().toString().padLeft(2, '0')}:00',
                            style: TextStyle(color: textGrey, fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 15,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(color: textGrey, fontSize: 10),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: textGrey.withOpacity(0.3),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: textGrey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                minX: 0,
                maxX: 12,
                minY: 0,
                maxY: 60,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 20),
                      FlSpot(2, 35),
                      FlSpot(4, 55),
                      FlSpot(6, 40),
                      FlSpot(8, 25),
                      FlSpot(10, 15),
                      FlSpot(12, 20),
                    ],
                    isCurved: true,
                    color: accentBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Alert Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 8,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 10,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'Mon';
                            break;
                          case 1:
                            text = 'Tue';
                            break;
                          case 2:
                            text = 'Wed';
                            break;
                          case 3:
                            text = 'Thu';
                            break;
                          case 4:
                            text = 'Fri';
                            break;
                          case 5:
                            text = 'Sat';
                            break;
                          case 6:
                            text = 'Sun';
                            break;
                          default:
                            text = '';
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(text, style: style),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      reservedSize: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(color: textGrey, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: textGrey.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: textGrey.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: textGrey.withOpacity(0.3),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: textGrey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                barGroups: [
                  _makeBarData(0, 2),
                  _makeBarData(1, 5),
                  _makeBarData(2, 3),
                  _makeBarData(3, 1),
                  _makeBarData(4, 4),
                  _makeBarData(5, 6),
                  _makeBarData(6, 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: accentYellow,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}
