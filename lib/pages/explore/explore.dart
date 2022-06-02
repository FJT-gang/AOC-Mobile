import 'package:flutter/material.dart';
// Providers
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
import 'package:aoc/providers/fireprov.dart';
// Services
import 'package:aoc/services/imgserv.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    ImgServ imgServ = ImgServ();
    imgServ.getUsers();
    return Scaffold(
      backgroundColor: themeProv.bgColor,
      body: Column(
        children: [],
      ),
    );
  }
}
