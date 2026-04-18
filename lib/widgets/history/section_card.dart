import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    required this.surfaceColor,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
  });

  final Widget child;
  final Color surfaceColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
