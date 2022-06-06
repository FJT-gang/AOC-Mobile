import 'package:aoc/general/globals.dart';
import 'package:aoc/pages/event.dart';
import 'package:flutter/material.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/fireprov.dart';

// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // remove 'late' but gives error
  late Map<DateTime, List<Event>> selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _eTitleC = TextEditingController();
  final TextEditingController _eDescriptionC = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  // @override
  // void dispose() {
  //   _eventController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var fireProv = Provider.of<FireProv>(context, listen: true);

    TimeOfDay eTime = TimeOfDay.now();

    return SafeArea(
        child: Scaffold(
      backgroundColor: Globals.bgDarkBlue,
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              headerMargin: const EdgeInsets.only(bottom: 20),
              formatButtonVisible: true,
              titleCentered: false,
              formatButtonShowsNext: false,
              decoration: BoxDecoration(
                color: Globals.bgLightBlue,
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.zero,
                  topEnd: Radius.zero,
                  bottomStart: Radius.circular(12),
                  bottomEnd: Radius.circular(12),
                ),
              ),
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
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Globals.white),
              weekendStyle: TextStyle(color: Globals.white),
            ),

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

            eventLoader: _getEventsfromDay,

            // To style the calendar
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(color: Globals.white),
              weekendTextStyle: TextStyle(color: Globals.white),
              //outsideTextStyle: TextStyle(color: Colors.grey[400]),
              outsideDaysVisible: false, //out-comment line above if true
              isTodayHighlighted: true,
              todayDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 107, 183, 246),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(color: Colors.black),
              selectedDecoration: BoxDecoration(
                color: Globals.bgLightBlue,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Globals.black),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map((Event event) => ListTile(
                title: Text(event.title),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Globals.bgLightBlue,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add event on this day"),
            content: Column(
              children: [
                TextFormField(
                  controller: _eTitleC,
                  decoration: const InputDecoration(hintText: 'Event Name'),
                ),
                ElevatedButton(
                    child: Text(eTime.toString()),
                    onPressed: () async {
                      eTime = (await showTimePicker(
                          context: context, initialTime: eTime))!;
                    }),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_eTitleC.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      // print(_eTitleC.text);
                      // print(selectedDay);
                      selectedEvents[selectedDay]!.add(
                        Event(title: _eTitleC.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eTitleC.text),
                      ];
                    }
                    fireProv.addEvent(_eTitleC.text, selectedDay, eTime.toString());
                  }
                  Navigator.pop(context);
                  _eDescriptionC.clear();
                  setState(() {});
                  return;
                },
                child: const Text("Ok"),
              )
            ],
          ),
        ),
        label: Text(
          "Add event",
          style: TextStyle(color: Globals.black),
        ),
        icon: Icon(
          Icons.add,
          color: Globals.black,
        ),
      ),
    ));
  }
}
