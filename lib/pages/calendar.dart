import 'package:aoc/general/globals.dart';
import 'package:aoc/widgets/meeting.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.bgDarkBlue,
      body: Wrap(children: <Widget>[
        Meeting(
          key: UniqueKey(),
          title: "Meeting 1",
          description: "Op dit event gaan we ...",
        )
      ]),
    );
  }
}
