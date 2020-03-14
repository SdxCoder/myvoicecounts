

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';

class SettingsService{

  Firestore _instance = Firestore.instance;
  final _userCollection = Firestore.instance.collection(Db.usersCollection);

  User _currentUser;
  User get currentUser => _currentUser;




  Future updateUser(Map<String, dynamic> map, String userId) async {
    try {
      await _instance.collection(Db.usersCollection)
          .document(userId)
          .updateData(map);
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future deleteUser(String id, FirebaseUser user) async {
    await _userCollection.document(id).delete().then((value){
      Firestore.instance.collection(Db.accountsDetails).document(id).setData({
        "deletedAt": DateTime.now(),
        "accountStatus" : "deleted"
      });
    });
  }


   Future getUser(String uid) async {
    try {
      var userData = await _userCollection.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

}