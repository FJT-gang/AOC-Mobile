import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Globals.bgLightBlue,
        child: Text('Chat'),
      ),
    );
  }
}
