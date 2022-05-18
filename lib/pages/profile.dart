//create a page to display the user's profile with the following information: name, profile picture, bio, and a list of the user's images.
// import 'dart:html';

import 'package:flutter/material.dart';
// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
import 'package:aoc/providers/fireprov.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profileHeight = 170;

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireProv = Provider.of<FireProv>(context, listen: true);
    var fireStream = Provider.of<List>(context, listen: true);

    var userId = FirebaseAuth.instance.currentUser!.uid;
    late String userName = "";

    fireStream.forEach((e) {
      if (userId == e.data().keys.toList().first) {
        userName = e.data()[userId]['name'];
      }
      // print(e.data()[fireProv.userId!.uid].toString());
    });
    // print('testttt');
    // print(fireProv.userId);
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeProv.grStart,
            themeProv.grEnd,
          ],
        )),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(),
                  IconButton(
                      onPressed: () {}, icon: Image.asset('assets/email.png')),
                  IconButton(
                      onPressed: () {}, icon: Image.asset('assets/phone.png')),
                  IconButton(
                      onPressed: () {}, icon: Image.asset('assets/insta.png')),
                ],
              ),
            ),
            Text('Welcome $userName'),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 8),
              child: const ThemeSelector(),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ]);
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset('assets/banner_image.jpg'),
        width: double.infinity,
        height: coverHeight,
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const AssetImage('assets/profile_image.jpeg'),
      );
  //zet bij de build content gwn de tekst die ge wilt.
}
