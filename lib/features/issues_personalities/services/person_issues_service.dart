
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import '../data/vote_person_issue_model.dart';

class PersonIssuesService {
  final _instance = Firestore.instance;

   Stream<QuerySnapshot> getIssuesStream(){
    return _instance.collection(Db.issuesCollection).snapshots();
  }

  Future addVoteForPersonIssue(VotePersonIssue vote, uid) async{
     try {
        await _instance.collection(Db.personIssuesVotesCollection).document("$uid-${DateTime.now().getDate()}").setData(vote.toMap());
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
