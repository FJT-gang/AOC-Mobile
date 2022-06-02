//create a page to display the user's profile with the following information: name, profile picture, bio, and a list of the user's images.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'dart:typed_data';
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
import 'package:aoc/providers/imageprov.dart';
// Serv
import 'package:aoc/services/imgserv.dart';

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
  bool ran = false;

  ImgServ imgServ = ImgServ();

  // Images
  String imgTl =
      'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
  String imgBl = 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
  String imgR = 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
  String imgPf = 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
  String imgBanner = 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireStream = Provider.of<List>(context, listen: true);
    var imageProv = Provider.of<ImageProv>(context, listen: true);

    var userId = FirebaseAuth.instance.currentUser!.uid;

    late String userName = '';
    String email = ' ';

    getRef(path) {
      return FirebaseStorage.instance.ref().child(path);
    }

    Future getImages() async {
      imageProv.reset();
      ran = true;
      final imgSourceList = await imgServ.getImages();
      for (var e in imgSourceList) {
        imageProv.sImages(Image.network(e));
        imageProv.sImages(const SizedBox(height: 200));
      }

      setState(() {});
    }

    void setImages() async {
      ran = true;
      imgTl = await imgServ.getImage('imgTl');
      imgBl = await imgServ.getImage('imgBl');
      imgR = await imgServ.getImage('imgR');
      imgPf = await imgServ.getImage('imgPf');
      imgBanner = await imgServ.getImage('imgBanner');
      setState(() {});
    }

    imgServ.getImage('tl');

    ran ? '' : setImages();

    Future pickImage(String location) async {
      try {
        pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        pickedImage;
        if (pickedImage == null) {
          return;
        } else {
          await imgServ.uploadImage('users/$userId/$location', pickedImage!);
          setImages();
        }
      } on PlatformException catch (e) {
        print('Failed to get image: $e');
      }
    }

    print('UserId: $userId');

    for (var e in fireStream) {
      if (userId == e.data().keys.toList().first) {
        userName = e.data()[userId]['name'];
        email = e.data()[userId]['email'];
        // setState(() {});
      }
      // print(e.data()[fireProv.userId!.uid].toString());
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
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                              color: Colors.grey,
                              child: GestureDetector(
                                onTap: () {
                                  pickImage('imgBanner');
                                },
                                child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 270,
                                    ),
                                    child: Image.network(
                                      imgBanner,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: ThemeSelector(),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 140),
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImage('imgPf');
                                    },
                                    child: CircleAvatar(
                                      radius: profileHeight / 2,
                                      backgroundColor: Colors.grey.shade800,
                                      backgroundImage: NetworkImage(imgPf),
                                    ),
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
                  Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(38, 25, 0, 25),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: const [
                              Text(
                                'Bio:    ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                'I like ... ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      print('img1');
                                      pickImage('imgTl');
                                    },
                                    child: Image.network(
                                      imgTl,
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      print('img2');
                                      pickImage('imgBl');
                                    },
                                    child: Image.network(
                                      imgBl,
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                  onTap: () {
                                    print('img3');
                                    pickImage('imgR');
                                  },
                                  child: Image.network(
                                    imgR,
                                    height: 215,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )))
                        ],
                      )
                    ]),
                  )
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
