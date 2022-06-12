import 'package:flutter/material.dart';


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