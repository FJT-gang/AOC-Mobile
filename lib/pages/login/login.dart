import 'package:flutter/material.dart';

// widgets
import 'package:aoc/pages/login/widgets/login_widget.dart';

// Globals
import 'package:aoc/general/globals.dart';

// Google fonts
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                        color: const Color.fromARGB(225, 0, 77, 121),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 300),
                // SizedBox(
                    // height: 300, child: Image.asset('assets/loginImg.png')),
                Column(
                  children: [
                    const SizedBox(height: 2),
                    LoginWidget(
                        text: 'Sign Up',
                        pressed: () {
                          Navigator.pushNamed(context, '/signup');
                        }),
                    const SizedBox(height: 2),
                    LoginWidget(
                        text: 'Sign In',
                        pressed: () {
                          Navigator.pushNamed(context, '/signin');
                        }),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
