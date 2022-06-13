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
        child: ListView(
          scrollDirection: Axis.vertical,
                      shrinkWrap: true,
          children: [
            Container(
                height: 40,
                width: 400,
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
                    const SizedBox(width: 45),
                    // const Text(
                    //   'Search results:',
                    //   style: TextStyle(fontSize: 30, color: Colors.white),
                    // ),
                  ],
                )),
            const SizedBox(height: 25),
            Center(child: Column(
              children: usrColumn)),
          ],
        ),
      ),
    );
  }
}
