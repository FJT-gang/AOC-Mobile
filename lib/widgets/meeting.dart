import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';

class Meeting extends StatefulWidget {
  final String title;
  final String description;

  const Meeting(
      {Key? key,
      this.title = "Title of the event",
      this.description = "Description"})
      : super(key: key);

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Globals.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Text(
              widget.description,
              style: TextStyle(
                  color: Globals.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
