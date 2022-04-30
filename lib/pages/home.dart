import 'package:flutter/material.dart';


// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Globals
import 'package:aoc/general/globals.dart';
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
        backgroundColor: themeProv.bgColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  )
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  const[
                  ThemeSelector(),
                  SizedBox(width: 60),
                  Text('Home', style: TextStyle(
                    fontSize: 40,
                  ),)
                ],),
              ),
            )
          ],),
        )
      ),
    );
  }
}

