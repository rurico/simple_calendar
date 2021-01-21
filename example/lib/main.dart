import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_calendar/simple_calendar.dart';
import 'package:simple_calendar/day_number_style_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Calendar', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: SimpleCalendar(
        currentDateColor: Colors.blue,
        highlightedDateColor: Colors.red[300],
        dayEvents: <DayEventsAtom>[
          DayEventsAtom(
            count: 1,
            time: DateTime(2021, 1, 11),
          )
        ],
      ),
    );
  }
}
