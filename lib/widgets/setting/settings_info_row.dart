import 'package:flutter/material.dart';

class SettingsInfoRow extends StatelessWidget {
  const SettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.labelColor,
    this.valueColor = Colors.white,
  });

  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: labelColor, fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(color: valueColor, fontSize: 15),
        ),
      ],
    );
  }
}
