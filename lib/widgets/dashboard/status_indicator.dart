import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.greenAccent,
          width: 3,
        ),
      ),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}