


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';

import '../data/vote_person_model.dart';

class CandidateService {
  final _instance = Firestore.instance;

 
  Stream<QuerySnapshot> getCandidatesStream(){
    return _instance.collection(Db.candidatesCollection).snapshots();
  }

   Future addVoteForPerson(VotePerson vote) async{

       DocumentSnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .document("${vote.documentId}-${vote.personId}-${DateTime.now().getDate()}")
        .get();

        
    if (snapshot.exists == false) {
      try {
        await _instance
            .collection(Db.personVotesCollection)
            .document("${vote.documentId}-${vote.personId}-${DateTime.now().getDate()}")
            .setData(vote.toMap());
      } catch (e) {
        return e.message;
      }
    }else{
       int voteIntegrity = await getPersonVoteIntegrityByDay(vote.documentId,vote.personId);
      await updatePersonVote({
        'personId': vote.personId,
        'personName': vote.personName,
        'adu': vote.adu,
        'date': vote.date,
        'ethnicity': vote.ethnicity,
        'age': vote.age,
        'gender': vote.gender,
        'party': vote.party,
        'race': vote.race,
        'state': vote.state,
        'id': vote.documentId,
        'voteIntegrity': voteIntegrity - 1
      }, vote.personId, vote.documentId);
    }

   
  }

   Future updatePersonVote(Map<String, dynamic> map, String id,String uid,) async {
    try {
      await _instance
          .collection(Db.personVotesCollection)
          .document("$uid-$id-${DateTime.now().getDate()}")
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

   Future<int> getPersonVoteIntegrityByDay(String uid,String id) async {
    int voteIntegrity = 2;
    DocumentSnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .document("$uid-$id-${DateTime.now().getDate()}")
        .get();

    if (snapshot.exists) {
      voteIntegrity = snapshot.data['voteIntegrity'];
      return voteIntegrity;
    } else {
      return voteIntegrity;
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
