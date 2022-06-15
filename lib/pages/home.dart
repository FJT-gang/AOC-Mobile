import 'package:flutter/material.dart';
// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return SafeArea(
      child: Scaffold(
          //backgroundColor: themeProv.bgColor,
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeProv.grStart,
            themeProv.grEnd,
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Column(
            // scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ThemeSelector(),
                      SizedBox(width: 60),
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  HomeCard(
                      cardTitle: 'Profile',
                      icon: Icons.person,
                      route: '/myprofile'),
                  HomeCard(
                    cardTitle: 'Explore',
                    icon: Icons.explore,
                    route: '/explore',
                  ),
                  // HomeCard(
                  //   cardTitle: 'Message',
                  //   icon: Icons.chat,
                  //   route: '/chatlist'
                  // )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

// WIDGETS

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  late String cardTitle;
  late String route;
  late IconData icon;
  HomeCard(
      {Key? key,
      required this.cardTitle,
      required this.icon,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
            color: themeProv.homecard,
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      icon,
                      size: 120,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
