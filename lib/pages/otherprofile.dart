import 'package:flutter/material.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Widgets
import 'package:aoc/pages/profile.dart';

// ignore: must_be_immutable
class OtherProfile extends StatelessWidget {
  late String userId;
  OtherProfile({required this.userId, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProfilePage(userId: userId, editRights: false,);
  }
}
