import 'package:flutter/cupertino.dart';

// Packages
import 'package:intl/intl.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireProv extends ChangeNotifier {
  var inst = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser;
  var now = DateFormat('EEEE, d/M/y').format(DateTime.now());

  Stream<List> get getCollections {
    return inst
        .collection('users')
        .snapshots()
        .map((snapshots) => snapshots.docs.toList());
  }

  void setUserData(String name, String email) {
    userId = FirebaseAuth.instance.currentUser;
    inst.collection('users').doc(userId!.uid).set({
      userId!.uid: {
        'name': name,
        'email': email,
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
