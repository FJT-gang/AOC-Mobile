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
        appBar: AppBar(
          title: const Text('AOC-Mobile'),
          backgroundColor: themeProv.bgColor,
          foregroundColor: Globals.black,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Column(children: const [
            ThemeSelector(),
          ],),
        )
      ),
    );
  }
}

