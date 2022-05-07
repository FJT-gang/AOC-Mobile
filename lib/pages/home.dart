import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/profile.dart';
import 'package:flutter/material.dart';

// Widgets
import 'package:aoc/widgets/themeWidget.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';

// Globals
import 'package:aoc/general/globals.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          backgroundColor: themeProv.bgColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black,
                  ))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        ThemeSelector(),
                        SizedBox(width: 60),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Ink.image(
                            image: const AssetImage('assets/calendarImg.jpg'),
                            // colorFilter: const ColorFilter.mode(Globals.bgOrange, BlendMode.color),
                            height: 240,
                            // width: 360,
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Calendar()));
                              },
                            ),
                          ),
                          const Text('Calendar',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Ink.image(
                            image: const AssetImage('assets/profileImg.jpg'),
                            // colorFilter: const ColorFilter.mode(Globals.bgOrange, BlendMode.color),
                            height: 240,
                            // width: 360,
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()));
                              },
                            ),
                          ),
                          const Text('Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
