//create a page to display the user's profile with the following information: name, profile picture, bio, and a list of the user's images.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  File? image;
  XFile? pickedImage;

  List<Widget> images = [];


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

    // Get images
    // Future getImages() async {
    //   const path = '/users/pSGHi6h0xOZIwOFFlhFU1EKWH403';
    //   final ref = FirebaseStorage.instance.ref().child(path);

    //   try {
    //     const oneMegabyte = 1024 * 1024;

    //   }
    // }

    // upload image
    Future uploadImage(String type) async {
      final path = '$type/${pickedImage!.name}';

      // reference waar afbeelding opgeslagen moet worden
      final ref = FirebaseStorage.instance.ref().child(path);
      // opslaan van afbeelding mbv ref
      ref.putFile(image!);
    }
    // Pick image
    Future pickImage() async {
      try {
        pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        pickedImage ?? '';
        if (pickedImage == null) {
          return;
        } else {
          image = File(pickedImage!.path);
          setState(() => {
                images.add(Image.file(
                  image!,
                  width: 300,
                  height: 400,
                )),
                images.add(
                  const SizedBox(height: 20),
                )
              });

          uploadImage('users/$userId');
        }
      } on PlatformException catch (e) {
        print('Failed to get image: $e');
      }
    }

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
                          Row(
                            children: [
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
                              const SizedBox(width: 18),
                              Padding(
                                padding: const EdgeInsets.only(top: 260),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        userName,
                                        style: const TextStyle(

                                          color: Colors.white,
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                          shadows: <Shadow>[
                                            // Shadow(
                                            //   offset: Offset(2, 2),
                                            //   blurRadius: 25,
                                            //   color: Colors.white,
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconT(
                                        text: email,
                                        icon: const Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ],
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
                      )),
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
}

class IconT extends StatelessWidget {
  late String text;
  late Icon icon;
  IconT({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      icon,
      const SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: TextStyle(color: Colors.white),
      )
    ]);
  }
}
