import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text("AOC-Mobile"),
          backgroundColor: themeProv.bgColor,
          foregroundColor: Globals.black,
          centerTitle: true,
        ),
        backgroundColor: Globals.bgLightBlue,
        body: Container(
            child: const ThemeSelector(),
            ),
      ),
    );
  }
}

// Theme selector
class ThemeSelector extends StatefulWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    return PopupMenuButton(
      color: themeProv.bgColor,
      elevation: 0,
      onSelected: (value) {
        Provider.of<ThemeProv>(context, listen: false).changeTheme(value);
      },
      child: const Text(
        'Thema',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 'blue',
            child: Center(
              child: Text(
                'Blauw',
                style: TextStyle(color: Colors.black),
              ),
            )),
        const PopupMenuItem(
            value: 'orange',
            child: Center(
              child: Text(
                'Oranje',
                style: TextStyle(color: Colors.black),
              ),
            )),
      ],
    );
  }
}
