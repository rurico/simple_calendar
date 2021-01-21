import 'package:flutter/material.dart';

import 'day_number_style_type.dart';

class DayNumber extends StatelessWidget {
  const DayNumber({
    @required this.year,
    @required this.month,
    @required this.day,
    this.style,
    this.onSelected,
  });

  final int year;
  final int month;
  final int day;
  final DayNumberStyle style;
  final DaySelectedCallback onSelected;

  @override
  Widget build(BuildContext context) {
    if (day < 1) {
      return const SizedBox.shrink();
    }

    final Padding widget = Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: style?.color is Color
                ? BoxDecoration(
                    color: style.color,
                    shape: BoxShape.circle,
                  )
                : null,
            child: Text(
              day.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: style?.color is Color ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
          if (style?.eventCount is int)
            SizedBox(
              width: 14,
              height: 14,
              child: Container(
                decoration: style?.highlightedDateColor is Color
                    ? BoxDecoration(
                        color: style.highlightedDateColor,
                        shape: BoxShape.circle,
                      )
                    : null,
                child: Center(
                  child: Text(
                    style.eventCount.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return InkWell(
      onTap: onSelected is DaySelectedCallback
          ? () => onSelected(DateTime(year, month, day))
          : null,
      child: widget,
    );
  }
}
