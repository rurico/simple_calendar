import 'package:flutter/material.dart';

class DayTitle extends StatelessWidget {
  const DayTitle({
    @required this.title,
    this.weekend,
  });

  final String title;
  final bool weekend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: weekend ? Colors.black38 : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
