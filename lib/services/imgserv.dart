import 'package:flutter/material.dart';
import 'dart:io';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// Packages
import 'package:image_picker/image_picker.dart';
// Widget
import 'package:aoc/pages/explore/searchbtn.dart';

class ImgServ {
  List imgList = [];

  getRef(path) {
    return FirebaseStorage.instance.ref().child(path);
  }

  // Get images
  // Future<List> getImages() async {
  //   final String path = 'users/$userId/';

  //   ListResult testlist =
  //       await FirebaseStorage.instance.ref().child(path).listAll();
  //   for (var i in testlist.items) {
  //     final imageUrl = await getRef(i.fullPath).getDownloadURL();
  //     imgList.add(imageUrl);
  //   }
  //   return imgList;
  // }

  // Get users
  Future<List<Widget>> getUsers() async {
    const String path = 'users/';

    List<Widget> userColumn = [];

    ListResult testlist =
        await FirebaseStorage.instance.ref().child(path).listAll();
    for (var i in testlist.prefixes) {
      String imgPf;
      if (!i.fullPath.contains('/')) {
        continue;
      }
      try {
        imgPf = await getRef('${i.fullPath}/imgPf').getDownloadURL();
      } catch (e) {
        continue;
      }
      userColumn.add(ProfLink(
        logoSource: imgPf,
        usrPath: i.fullPath,
      ));
    }
    return userColumn;
  }

  Future getImage(String imgType, userId) async {
    final String path = 'users/$userId/$imgType';
    try {
      final Reference imageRef = FirebaseStorage.instance.ref().child(path);
      final imgUrl = await getRef(imageRef.fullPath).getDownloadURL();
      return imgUrl;
    } catch (e) {
      return 'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png';
    }
  }

  // Upload images
  Future uploadImage(String path, XFile pickedImage) async {
    // reference waar afbeelding opgeslagen moet worden
    // opslaan van afbeelding mbv ref
    await getRef(path).putFile(File(pickedImage.path));
    return '';
  }
}
