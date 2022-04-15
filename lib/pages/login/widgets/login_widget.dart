import 'package:flutter/material.dart';

// Globals
import 'package:aoc/general/globals.dart';


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
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Globals.bgDarkBlue),
            elevation: MaterialStateProperty.all(0),
            // shape: MaterialStateProperty.all(
              // RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(18),
              // ),
            // ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
