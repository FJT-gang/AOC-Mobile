import 'package:flutter/material.dart';

// Pages
import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/home.dart';
import 'package:aoc/pages/login/login.dart';
import 'package:aoc/pages/login/signup.dart';
import 'package:aoc/pages/login/signIn.dart';

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
        '/signup': (context) => SignUpPage(),
        '/signin': (context) => SignInPage(),
        '/home': (context) => Home(),
        '/calendar': (context) => Calendar(),
      },
    ));
