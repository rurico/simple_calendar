import 'dart:ui';

typedef DaySelectedCallback = void Function(DateTime dateTime);
typedef DayNumberStyleFunction = DayNumberStyle Function(DateTime dateTime);

abstract class DayEventsAtom {
  final int count;
  final DateTime time;
  const DayEventsAtom({
    this.count,
    this.time,
  });
}

class DayNumberStyle {
  Color color;
  Color highlightedDateColor;
  int eventCount;
  DayNumberStyle({
    this.color,
    this.highlightedDateColor,
    this.eventCount,
  });
}
