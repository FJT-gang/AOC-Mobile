import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/home.dart';
import 'package:aoc/pages/welcome.dart';
import 'package:aoc/pages/login.dart';
import 'package:flutter/material.dart';


// Google Fonts
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      title: "AOC Mobile",
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => LoginPage(),
        '/home': (context) => Home(),
        '/calendar': (context) => Calendar(),
      },
    ));
