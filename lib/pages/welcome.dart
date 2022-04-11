import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aoc/pages/login.dart';
import 'package:aoc/general/globals.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.bgLightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Globals.bgDarkBlue,
                  textStyle: TextStyle(color: Colors.white),
                  minimumSize: Size(150, 100)),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(),
            ElevatedButton(
              child: Text(
                'Register',
                style: TextStyle(fontSize: 30),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Globals.bgDarkBlue,
                  textStyle: TextStyle(color: Colors.white),
                  minimumSize: Size(150, 100)),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
