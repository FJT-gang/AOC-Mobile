import 'package:flutter/material.dart';

class ProfLink extends StatelessWidget {
  late String logoSource;
  late String usrName;
  ProfLink({required this.logoSource, required this.usrName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(logoSource),
        Text(usrName),
      ],
    );
  }
}