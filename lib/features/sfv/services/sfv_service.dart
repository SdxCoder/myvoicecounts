import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/features/sfv/data/sfv_model.dart';
import '../../../core/core.dart';

class SfvService {
  final _firestore = Firestore.instance;

  Stream<QuerySnapshot> getSfvStream() {
    return _firestore.collection(Db.sfvCollection).snapshots();
  }

  Future getSfvSnapshots() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(Db.sfvCollection).getDocuments();
      return snapshot.documents;
    } catch (e) {
      return e.message;
    }
  }

  Future updateSfv(Map<String, dynamic> map, String sfvId) async {
    int agree = 0;
    int disagree = 0;
    int undecided = 0;

    DocumentSnapshot snapshot =
        await _firestore.collection(Db.sfvCollection).document(sfvId).get();
    if (snapshot.exists) {
      agree = snapshot.data['agree'];
      disagree = snapshot.data['disagree'];
      undecided = snapshot.data['undecided'];
    }

    map['agree'] = map['agree'] + agree;
    map['disagree'] = map['disagree'] + disagree;
    map['undecided'] = map['undecided'] + undecided;

    try {
      await _firestore
          .collection(Db.sfvCollection)
          .document(sfvId)
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
}
