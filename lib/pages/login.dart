import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Globals
import 'package:aoc/general/globals.dart';
import 'package:google_fonts/google_fonts.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //make two inputfields to enter username and password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Globals.bgLightBlue,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 90),
                Text('Welcome',
                    style: GoogleFonts.scada(
                      textStyle: const TextStyle(fontSize: 60),
                      // fontWeight: FontWeight.w600
                    )),
                const SizedBox(height: 290),
                Column(
                  children: [
                    LoginWidget(
                      text: 'Sign In',
                      route: '/home'
                      ),
                    const SizedBox(height: 2),
                    LoginWidget(
                      text: 'Sign Up',
                      route: '/home'
                      ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class LoginWidget extends StatelessWidget {
  late String text;
  late String route;

  LoginWidget({
    Key? key, 
    required this.text,
    this.route = '/login'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
            primary: Globals.bgDarkBlue,
            textStyle: const TextStyle(
              color: Colors.white,
            ),
            maximumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
