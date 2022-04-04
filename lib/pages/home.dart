import 'package:aoc/general/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Globals.bgLightBlue,
        body: Center(
          child: Container(
            child: Text(
              'Hey',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ));
  }
}
