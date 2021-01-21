import 'package:flutter/material.dart';

import 'day_number.dart';
import 'day_number_style_type.dart';

class MonthView extends StatefulWidget {
  const MonthView({
    @required this.year,
    @required this.month,
    @required this.daySelectedCallback,
    @required this.dayNumberStyleFunction,
  });

  final int year;
  final int month;
  final DaySelectedCallback daySelectedCallback;
  final DayNumberStyleFunction dayNumberStyleFunction;

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  List<DayNumber> _monthDays;

  @override
  void initState() {
    final int daysInMonth = getDaysInMonth(widget.year, widget.month);
    final int firstWeekdayOfMonth =
        DateTime(widget.year, widget.month, 1).weekday;
    _monthDays = genMonthDays(daysInMonth, firstWeekdayOfMonth);
    super.initState();
  }

  int getDaysInMonth(int year, int month) {
    return month < DateTime.monthsPerYear
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;
  }

  List<DayNumber> genMonthDays(int daysInMonth, int firstWeekdayOfMonth) {
    return <DayNumber>[
      for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++)
        DayNumber(
          year: widget.year,
          month: widget.month,
          day: day,
          style: widget.dayNumberStyleFunction(
            DateTime(widget.year, widget.month, day),
          ),
          onSelected: widget.daySelectedCallback,
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List<DayNumber>.generate(
        _monthDays.length,
        (int index) => _monthDays[index],
      ),
    );
  }
}
