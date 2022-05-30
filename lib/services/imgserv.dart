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
    const String path = 'users/pSGHi6h0xOZIwOFFlhFU1EKWH403/';

    ListResult testlist =
        await FirebaseStorage.instance.ref().child(path).listAll();
    for (var i in testlist.items) {
      final imageUrl = await getRef(i.fullPath).getDownloadURL();
      imgList.add(imageUrl);
    }
    return imgList;
  }

  Future getImage(String imgType) async {
    final String path = 'users/pSGHi6h0xOZIwOFFlhFU1EKWH403/$imgType';
    final Reference imageRef = FirebaseStorage.instance.ref().child(path);
    final imgUrl = await getRef(imageRef.fullPath).getDownloadURL();
    return imgUrl;
  }

  // Upload images
  Future uploadImage(String path, XFile pickedImage) async {
    // reference waar afbeelding opgeslagen moet worden
    // opslaan van afbeelding mbv ref
    getRef(path).putFile(File(pickedImage.path));
  }
}
