

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';

class SettingsService{

  Firestore _instance = Firestore.instance;



  Future updateUser(User user) async {
    try {
      await _instance.collection(Db.usersCollection)
          .document(user.id)
          .updateData(user.toJson());
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}