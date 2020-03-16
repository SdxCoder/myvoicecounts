


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';

import '../data/vote_person_model.dart';

class CandidateService {
  final _instance = Firestore.instance;

 
  Stream<QuerySnapshot> getCandidatesStream(){
    return _instance.collection(Db.candidatesCollection).snapshots();
  }

   Future addVoteForPerson(VotePerson vote, uid) async{
     try {
        await _instance.collection('votesByPerson-${DateTime.now().getDate()}').document(uid).setData(vote.toMap());
      } catch (e) {
        return e.message;
      }
  }

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

}
