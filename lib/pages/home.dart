import 'package:flutter/material.dart';

// Widgets
import 'package:aoc/widgets/themeWidget.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
import 'package:aoc/providers/fireprov.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireProv = Provider.of<FireProv>(context, listen: true);



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
                    HomeCard(
                        cardTitle: 'Calendar',
                        imgSource: 'assets/calendarImg${themeProv.color}.jpg',
                        route: '/calendar'),
                    const SizedBox(height: 20),
                    HomeCard(
                        cardTitle: 'Profile',
                        imgSource: 'assets/profileImg.jpg',
                        route: '/profile')
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class HomeCard extends StatelessWidget {
  late String imgSource;
  late String cardTitle;
  late String route;
  HomeCard(
      {Key? key,
      required this.imgSource,
      required this.cardTitle,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(imgSource),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            height: 240,
            width: 360,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, route);
              },
            ),
          ),
          Text(cardTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ))
        ],
      ),
    );
  }
}
