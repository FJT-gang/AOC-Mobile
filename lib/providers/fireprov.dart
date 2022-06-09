import 'package:flutter/cupertino.dart';

// Packages
import 'package:intl/intl.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireProv extends ChangeNotifier {
  var inst = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var userName = '';
  var now = DateFormat('EEEE, d/M/y').format(DateTime.now());

  Stream<List> get getCollections {
    return inst
        .collection('users')
        .snapshots()
        .map((snapshots) => snapshots.docs.toList());
  }

  void setUserData(String name, String email) {
    var userId = FirebaseAuth.instance.currentUser;
    userName = name;
    inst.collection('users').doc(userId!.uid).set({
      userId.uid: {
        'name': name,
        'email': email,
      }
    });
  }

  void addEvent(String title, DateTime day, String startTime) {
    inst.collection('calendar').add({
      title: {
        'title': title,
        'user': userName,
        'creationDate': DateTime.now(),
        'day': day,
        'startTime': startTime,
      }
    });
  }

  void sendMessages(String toUserId, String message) {
    List<String> userList = [toUserId, userId];
    userList.sort();
    final String messageId = '${userList[0]}${userList[1]}';
    var now = DateTime.now();
    inst.collection('messages').doc(messageId).collection(now.toString()).add({
      now.toString(): {
        'from': userId,
        'message': message,
      }
    });
  }

  // void changeShoe(afstand, naam) {
  //   inst.collection(userId!.uid).doc(naam.toString()).set({
  //     'afstand': afstand.toString(),
  //     'naam': naam.toString(),
  //     'laatst_bewerkt': now,
  //   });
  //   notifyListeners();
  // }
}
