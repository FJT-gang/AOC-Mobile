import 'package:flutter/material.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Widgets
import 'package:aoc/pages/profile.dart';

// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);
  var userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return ProfilePage(userId: userId, editRights: true,);
  }
}
