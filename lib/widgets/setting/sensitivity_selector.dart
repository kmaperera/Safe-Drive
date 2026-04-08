import 'package:flutter/material.dart';

class SensitivitySelector extends StatelessWidget {
  const SensitivitySelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.accentColor,
  });

  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < options.length; i++) ...[
          if (i != 0) const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(options[i]),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedValue == options[i]
                      ? accentColor
                      : const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selectedValue == options[i]
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
