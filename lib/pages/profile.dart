//create a page to display the user's profile with the following information: name, profile picture, bio, and a list of the user's images.

import 'package:flutter/material.dart';
// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';
import 'package:aoc/providers/fireprov.dart';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profileHeight = 170;

  // Image picker
  File? image;

  List<Widget> images = [];

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage ?? '';
      if (pickedImage == null) {
        return;
      } else {
        final imageTemp = File(pickedImage.path);
        setState(() => {
          images.add(
            Image.file(
              imageTemp,
              width: 300,
              height: 400,
          )),
          images.add(
            SizedBox(height: 20),
          )
          
          });
      }
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireProv = Provider.of<FireProv>(context, listen: true);
    var fireStream = Provider.of<List>(context, listen: true);

    var userId = FirebaseAuth.instance.currentUser!.uid;

    late String userName = '';
    String email = ' ';

    fireStream.forEach((e) {
      if (userId == e.data().keys.toList().first) {
        userName = e.data()[userId]['name'];
        email = e.data()[userId]['email'];
        setState(() {});
      }
      // print(e.data()[fireProv.userId!.uid].toString());
    });


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
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: Colors.grey,
                            child: Image.asset('assets/banner_image.jpg'),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 140),
                              child: CircleAvatar(
                                radius: profileHeight / 2,
                                backgroundColor: Colors.grey.shade800,
                                backgroundImage: const AssetImage(
                                    'assets/profile_image.jpeg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconT(text: userName, icon: const Icon(Icons.person)),
                      IconT(
                          text: email, icon: const Icon(Icons.email_outlined)),
                          Text('Welcome $userName'),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12, top: 8),
                        child: ThemeSelector(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                      child: const Text('Select Image')),
                      SingleChildScrollView(
                            child: Column(
                              children: images,
                            )
                          ),
                    ],
                  ),
                  
                ],
              ),
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
    );
  }
}

class IconT extends StatelessWidget {
  late String text;
  late Icon icon;
  IconT({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, Text(text)]);
  }
}
