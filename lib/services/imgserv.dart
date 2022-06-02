import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:aoc/providers/imageprov.dart';
import 'package:aoc/providers/fireprov.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:aoc/pages/explore/searchbtn.dart';

class ImgServ {
  List imgList = [];
  var userId = FirebaseAuth.instance.currentUser!.uid;

  getRef(path) {
    return FirebaseStorage.instance.ref().child(path);
  }

  // Get images
  Future<List> getImages() async {
    final String path = 'users/$userId/';

    ListResult testlist =
        await FirebaseStorage.instance.ref().child(path).listAll();
    for (var i in testlist.items) {
      final imageUrl = await getRef(i.fullPath).getDownloadURL();
      imgList.add(imageUrl);
    }
    return imgList;
  }

  // Get users
  Future getUsers() async {
    final String path = 'users/';

    List userColumn = [];

    ListResult testlist =
        await FirebaseStorage.instance.ref().child(path).listAll();
    for (var i in testlist.prefixes) {
      print(i.fullPath);

      String imgPf; 
      try {
        imgPf = await getRef('${i.fullPath}/imgPf').getDownloadURL();
      }  catch(e){
        imgPf = 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
      }

      userColumn.add({
        ProfLink(
          logoSource: imgPf,
          usrName: i.fullPath,
        )
      });
    }
    // return ProfLink(
    //   logoSource: logoSource,
    //   usrName: usrName
    //   );
  }

  Future getImage(String imgType) async {
    final String path = 'users/$userId/$imgType';
    try {
      final Reference imageRef = FirebaseStorage.instance.ref().child(path);
      final imgUrl = await getRef(imageRef.fullPath).getDownloadURL();
      return imgUrl;
    } catch (e) {
      return 'https://i.pinimg.com/736x/1c/53/c5/1c53c5b3f3c6e788bfd32f2b4d54ed59.jpg';
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
