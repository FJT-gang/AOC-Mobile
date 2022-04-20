import 'package:aoc/pages/profile.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/home.dart';
import 'package:aoc/pages/login/login.dart';
import 'package:aoc/pages/login/signup.dart';
import 'package:aoc/pages/login/signIn.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';


// Firebase
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: GoogleFonts.robotoTextTheme(),
    ),
    debugShowCheckedModeBanner: false,
    title: "AOC Mobile",
    initialRoute: '/home ',
    routes: {
      '/login': (context) => LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/signin': (context) => SignInPage(),
      '/home': (context) => Home(),
      '/calendar': (context) => Calendar(),
      '/profile': (context) => ProfilePage(),
    },
  ));
}
