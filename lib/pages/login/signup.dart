import 'package:flutter/material.dart';

// widgets
import 'package:aoc/pages/login/widgets/login_widget.dart';

// Globals
import 'package:aoc/general/globals.dart';

// Google fonts
import 'package:google_fonts/google_fonts.dart';

// firebase
import 'package:firebase_auth/firebase_auth.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
import 'package:aoc/providers/fireprov.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireProv = Provider.of<FireProv>(context, listen: true);

    return Scaffold(
      backgroundColor: Globals.bgLightBlue,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              'Sign Up',
              style: GoogleFonts.scada(
                  textStyle: const TextStyle(fontSize: 60),
                  color: const Color.fromARGB(225, 0, 77, 121),
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    NewInput(
                      placeholder: "Enter Username",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 10),
                    NewInput(
                      placeholder: "Enter Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    NewInput(
                      placeholder: "Enter Password",
                      controller: passwordController,
                      obscure: true,
                    ),
                    const SizedBox(height: 40),
                    LoginWidget(
                      text: 'Sign Up',
                      pressed: () {
                        RegExp regExp =  RegExp(
                          r"^[a-zA-Z]{2,10}$",
                          caseSensitive: false,
                          multiLine: false,
                        );

                        if (!regExp.hasMatch(usernameController.text)) {
                          print('unvalid username');
                          showDialog(
                              context: context,
                              builder: (context) => Alert(
                                title: 'Unvalid Username', 
                                content: 'Please enter a name between 2 and 10 letters.',)
                                );
                        } else {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then((_) =>  fireProv.setUserData(
                                usernameController.text, 
                                emailController.text,
                                ))
                              .then((_) => Navigator.pushReplacementNamed(
                                  context, '/home'));
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NewInput extends StatelessWidget {
  late String placeholder;
  late TextEditingController controller;
  late bool obscure;
  NewInput(
      {Key? key,
      this.placeholder = '',
      required this.controller,
      this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: placeholder,
        // focusColor: themeProv.btnColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  late String title;
  late String content;
  Alert({ Key? key , required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
          content),
            actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
    );
  }
}