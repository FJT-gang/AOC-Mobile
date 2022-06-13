import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';
// Providers
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
// Services
import 'package:aoc/services/imgserv.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

bool ran = false;
List<Widget> usrColumn = [];

class _ExploreState extends State<Explore> {
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
      body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 65,
                  width: 400,
                  decoration: BoxDecoration(
                    color: themeProv.homecard,
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.zero,
                      topEnd: Radius.zero,
                      bottomStart: Radius.circular(8),
                      bottomEnd: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      SizedBox(width: 60),
                      Text(
                        'All accounts:',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(height: 25),
              Center(child: Column(children: usrColumn)),
            ],
          ),
      ),
    );
  }
}
