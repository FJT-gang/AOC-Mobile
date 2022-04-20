import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AOC-Mobile"),
          backgroundColor: Globals.bgDarkBlue,
          foregroundColor: Globals.black,
          centerTitle: true,
        ),
        backgroundColor: Globals.bgLightBlue,
        body: Container(
            // events tonen? view met title & date?
            ),
      ),
    );
  }
}
