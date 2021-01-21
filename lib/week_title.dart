import 'package:flutter/material.dart';

import 'day_title.dart';

class WeekTitle extends StatefulWidget {
  const WeekTitle();
  @override
  _WeekTitleState createState() => _WeekTitleState();
}

class _WeekTitleState extends State<WeekTitle> {
  final List<String> titleList = <String>[
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
    '七',
  ];
  List<DayTitle> titles = <DayTitle>[];
  @override
  void initState() {
    titles = initTitleList();
    super.initState();
  }

  List<DayTitle> initTitleList() {
    return <DayTitle>[
      for (int i = 0; i < titleList.length; i++)
        DayTitle(title: '周${titleList[i]}', weekend: i > 4)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List<Widget>.generate(
        titles.length,
        (int index) => titles[index],
      ),
    );
  }
}
