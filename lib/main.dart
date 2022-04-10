import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/home.dart';
import 'package:aoc/pages/welcome.dart';
import 'package:aoc/pages/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AOC Mobile",
      home: Calendar(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => LoginPage(),
        '/home': (context) => Home(),
        '/calendar': (context) => Calendar(),
      },
    ));
