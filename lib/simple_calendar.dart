import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'day_number_style_type.dart';
import 'month_view.dart';
import 'week_title.dart';

class SimpleCalendar extends StatefulWidget {
  final Color currentDateColor;
  final Color highlightedDateColor;
  final List<DayEventsAtom> dayEvents;
  final DaySelectedCallback daySelectedCallback;

  const SimpleCalendar({
    this.currentDateColor,
    this.highlightedDateColor,
    this.dayEvents,
    this.daySelectedCallback,
  });
  @override
  _SimpleCalendarState createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  PageController _pageController;
  final WeekTitle _weekTitle = const WeekTitle();
  final Map<int, Map<int, MonthView>> _monthViewCache =
      <int, Map<int, MonthView>>{};

  final List<MonthView> _monthViewList = <MonthView>[];
  final int firstDate = 2000;
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _setMonthViewList(now.year, now.month);
  }

  MonthView _getMonthViewData(int year, int month) {
    if (_monthViewCache[year] is Map && _monthViewCache[year][month] is Map) {
      final MonthView data = _monthViewCache[year][month];
      if (data is MonthView) {
        return data;
      }
    }
    return _getSliderMonthView(year, month);
  }

  MonthView _getSliderMonthView(int year, int month) {
    final MonthView data = _sliderMonthView(year, month);
    _saveMonthViewData(data, year, month);
    return data;
  }

  void onDaySelectedCallback(DateTime dateTime) {
    if (widget.daySelectedCallback is DaySelectedCallback)
      widget.daySelectedCallback(dateTime);
  }

  DayNumberStyle _getDayNumberStyle(DateTime dateTime) {
    final isCurrentDate = dateTime.isAtSameMomentAs(
      DateTime(now.year, now.month, now.day),
    );

    DayNumberStyle _dayNumberStyle = DayNumberStyle();

    if (isCurrentDate) {
      _dayNumberStyle.color = widget.currentDateColor;
    }

    final event = widget.dayEvents.firstWhere((DayEventsAtom events) {
      return dateTime.isAtSameMomentAs(
        DateTime(
          events.time.year,
          events.time.month,
          events.time.day,
        ),
      );
    }, orElse: () => null);

    if (event is DayEventsAtom) {
      _dayNumberStyle.eventCount = event.count;
      _dayNumberStyle.highlightedDateColor = widget.highlightedDateColor;
    }

    return _dayNumberStyle;
  }

  MonthView _sliderMonthView(int year, int month) {
    if (month < 1) {
      return MonthView(
        year: year - 1,
        month: 12,
        daySelectedCallback: onDaySelectedCallback,
        dayNumberStyleFunction: _getDayNumberStyle,
      );
    }
    if (month > 12) {
      return MonthView(
        year: year + 1,
        month: 1,
        daySelectedCallback: onDaySelectedCallback,
        dayNumberStyleFunction: _getDayNumberStyle,
      );
    }
    return MonthView(
      year: year,
      month: month,
      daySelectedCallback: onDaySelectedCallback,
      dayNumberStyleFunction: _getDayNumberStyle,
    );
  }

  void _saveMonthViewData(MonthView monthView, int year, int month) {
    if (_monthViewCache[year] is! Map)
      _monthViewCache[year] = <int, MonthView>{};
    _monthViewCache[year][month] = monthView;
  }

  void _setMonthViewList(int year, int month) {
    _monthViewList.addAll(List<MonthView>.generate(
      3,

      /// `month + index - 1` 当前月份前一个月
      (int index) => _getMonthViewData(year, month + index - 1),
    ));
  }

  void _resetPageState() {
    _pageController.jumpToPage(2);

    _pageController.previousPage(
      duration: const Duration(microseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (int index) {
        final MonthView monthViewData = _monthViewList[index];
        if (index == _monthViewList.length - 1) {
          _monthViewList.add(
            _getMonthViewData(monthViewData.year, monthViewData.month + 1),
          );
        }
        if (index == 0) {
          _monthViewList.insert(
            0,
            _getMonthViewData(monthViewData.year, monthViewData.month - 1),
          );
          _resetPageState();
        }
        setState(() {});
      },
      itemCount: _monthViewList.length,
      itemBuilder: (BuildContext context, int index) {
        final MonthView monthViewData = _monthViewList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () async {
                final DateTime dateTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime(firstDate),
                  initialDate: DateTime(
                    monthViewData.year > firstDate
                        ? monthViewData.year
                        : firstDate,
                    monthViewData.month,
                  ),
                  lastDate: DateTime(2099),
                );
                if (dateTime is DateTime) {
                  _resetPageState();
                  setState(() {
                    _monthViewList.clear();
                    _setMonthViewList(dateTime.year, dateTime.month);
                  });
                }
              },
              child: Text(
                '${monthViewData.year}-${monthViewData.month}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            _weekTitle,
            monthViewData
          ],
        );
      },
    );
  }
}
