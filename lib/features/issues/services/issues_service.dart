
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import '../data/vote_issue_model.dart';
import '../data/states_model.dart';

class IssuesService {
  final _instance = Firestore.instance;

   Stream<QuerySnapshot> getIssuesStream(){
    return _instance.collection(Db.issuesCollection).snapshots();
  }

  Future addVoteForIssue(VoteIssue vote, uid) async{
     try {
        await _instance.collection(Db.issueVotesCollection).document("$uid-${DateTime.now().getDate()}").setData(vote.toMap());
      } catch (e) {
        return e.message;
      }
  }

   Future addVoteToStates(TopStates states, uid) async{
     DocumentSnapshot snapshot = await _instance.collection(Db.topStates).document("${states.state} - ${DateTime.now().getDate()}").get();
      int votes = 0;
     if(snapshot.exists){
       votes = snapshot.data['votes'];
       votes = votes + 1;
       states = TopStates(date: DateTime.now().toUtc(), state: states.state, votes: votes);
     }
     try {
        await _instance.collection(Db.topStates).document("${states.state} - ${DateTime.now().getDate()}").setData(states.toMap());
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
