// <uses-permission android:name="android.permission.INTERNET"/>
// flutter build apk --build-name=1.0.1 --build-number=2

import 'package:aoc/pages/chat.dart';
import 'package:aoc/pages/profile.dart';
import 'package:aoc/providers/imageprov.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:aoc/pages/calendar.dart';
import 'package:aoc/pages/home.dart';
import 'package:aoc/pages/explore/explore.dart';
import 'package:aoc/pages/login/login.dart';
import 'package:aoc/pages/login/signup.dart';
import 'package:aoc/pages/login/signIn.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:aoc/providers/fireprov.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProv()),
    ChangeNotifierProvider(create: (context) => FireProv()),
    StreamProvider<List>(
      create: (context) => FireProv().getCollections,
      initialData: const [],
    ),
    ChangeNotifierProvider(create: (context) => ImageProv())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      title: "AOC Mobile",
      initialRoute: '/chat',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/signin': (context) => SignInPage(),
        '/home': (context) => const Home(),
        '/calendar': (context) => const Calendar(),
        '/profile': (context) => const ProfilePage(),
        '/explore': (context) => const Explore(),
        '/chat': (context) => const Chat(),
      },
    );
  }
}
