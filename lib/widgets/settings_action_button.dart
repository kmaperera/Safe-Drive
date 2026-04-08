import 'package:flutter/material.dart';

class SettingsActionButton extends StatelessWidget {
  const SettingsActionButton({
    super.key,
    required this.text,
    required this.surfaceColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.onPressed,
  });

  final String text;
  final Color surfaceColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: surfaceColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
