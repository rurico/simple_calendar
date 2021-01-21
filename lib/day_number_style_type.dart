import 'dart:ui';

typedef DaySelectedCallback = void Function(DateTime dateTime);
typedef DayNumberStyleFunction = DayNumberStyle Function(DateTime dateTime);

class DayEventsAtom {
  final int count;
  final DateTime dateTime;
  const DayEventsAtom({
    this.count,
    this.dateTime,
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
