import 'package:flutter/cupertino.dart';

// Packages
import 'package:intl/intl.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';

class FireProv extends ChangeNotifier {
  var inst = FirebaseFirestore.instance;
  // var userId = FirebaseAuth.instance.currentUser!.uid;
  var userName = '';
  var now = DateFormat('EEEE, d/M/y').format(DateTime.now());

  Stream<List> get getCollections {
    return inst
        .collection('users')
        .snapshots()
        .map((snapshots) => snapshots.docs.toList());
  }

  void setUserData(String name, String email) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    userName = name;
    inst.collection('users').doc(userId).set({
      userId: {
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

  // Messages
  String getMessageId(ohterUser) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> userList = [ohterUser, userId];
    userList.sort();
    return '${userList[0]}${userList[1]}';
  }

  void sendMessages(String toUserId, String message, String type) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final String messageId = getMessageId(toUserId);
    var date = DateTime.now();
    inst.collection('messages').doc(messageId).collection('message').add({
      date.toString(): {
        'sender': userId,
        'message': message,
        'type': type,
      }
    });
  }

  Stream<List>? getMessages(fromUserId) {
    final String messageId = getMessageId(fromUserId);
    return inst
        .collection('messages')
        .doc(messageId)
        .collection('message')
        .snapshots()
        .map((snapshots) => snapshots.docs.toList());
  }
}
