import 'package:aoc/general/globals.dart';
import 'package:aoc/widgets/meeting.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Globals.bgDarkBlue,
            body: TableCalendar(
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: selectedDay,
              firstDay: DateTime(2022),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,

              // Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              // To style the calendar
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Globals.white),
                weekendTextStyle: TextStyle(color: Globals.white),
                //outsideTextStyle: TextStyle(color: Colors.grey[400]),
                outsideDaysVisible: false, //out-comment line above if true
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Globals.black),
                selectedDecoration: BoxDecoration(
                  color: Globals.bgLightBlue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Globals.black),
              ),
            )));
  }
}
