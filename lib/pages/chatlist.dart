import 'package:aoc/services/imgserv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/themeprov.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

bool ran = false;
List<Widget> usrColumn = [];

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    ImgServ imgServ = ImgServ();

    Future setUsers() async {
      ran = true;
      usrColumn = await imgServ.getUsers();
      setState(() {});
    }

    !ran ? setUsers() : "";

    return Scaffold(
    backgroundColor: themeProv.bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: usrColumn
    ));
  }
}
