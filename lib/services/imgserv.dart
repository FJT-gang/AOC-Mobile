import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:aoc/providers/imageprov.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImgServ {
  List imgList = [];

  getRef(path) {
      return FirebaseStorage.instance.ref().child(path);
  }

  // Get images
  Future<List> getImages() async {
    const path =
        'users/pSGHi6h0xOZIwOFFlhFU1EKWH403/image_picker3221195033689746631.webp';
    const testPath = 'users/pSGHi6h0xOZIwOFFlhFU1EKWH403/';

    ListResult testlist =
        await FirebaseStorage.instance.ref().child(testPath).listAll();
    for (var i in testlist.items) {
      final imageUrl =
            await getRef(i.fullPath).getDownloadURL();
      imgList.add(imageUrl);
    }
    return imgList;
  }


  // Upload images
  Future uploadImage(String type, XFile pickedImage) async {
      final path = '$type/${pickedImage.name}';

      // reference waar afbeelding opgeslagen moet worden
      // opslaan van afbeelding mbv ref
      getRef(path).putFile(File(pickedImage.path));
    }
}
