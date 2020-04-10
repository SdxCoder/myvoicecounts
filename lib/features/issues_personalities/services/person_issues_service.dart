import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import '../data/vote_person_issue_model.dart';

class PersonIssuesService {
  final _instance = Firestore.instance;

  Stream<QuerySnapshot> getIssuesStream() {
    return _instance.collection(Db.issuesCollection).snapshots();
  }

  Future addVoteForPersonIssue(VotePersonIssue vote) async {
    DocumentSnapshot snapshot = await _instance
        .collection(Db.personIssuesVotesCollection)
        .document(
            "${vote.documentId}-${vote.personId}-${vote.issueId}-${DateTime.now().getDate()}")
        .get();

    if (snapshot.exists == false) {
      try {
        await _instance
            .collection(Db.personIssuesVotesCollection)
            .document("${vote.documentId}-${vote.personId}-${vote.issueId}-${DateTime.now().getDate()}")
            .setData(vote.toMap());
      } catch (e) {
        return e.message;
      }
    }else{
       int voteIntegrity = await getPersonIssueVoteIntegrityByDay(vote.documentId,vote.personId, vote.issueId);
      await updatePersonIssueVote({
        'personId': vote.personId,
        'personName':vote.personName,
        'issueId': vote.issueId,
        'issueName': vote.issueName,
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
      }, vote.issueId, vote.personId, vote.documentId);
    }
  }

  Future updatePersonIssueVote(Map<String, dynamic> map, String issueId, String personId, String uid) async {
    try {
      await _instance
          .collection(Db.personIssuesVotesCollection)
          .document("$uid-$personId-$issueId-${DateTime.now().getDate()}")
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

  Future<int> getPersonIssueVoteIntegrityByDay(String uid, String personId, String issueId) async {
    int voteIntegrity = 1;
    DocumentSnapshot snapshot = await _instance
        .collection(Db.personIssuesVotesCollection)
        .document("$uid-$personId-$issueId-${DateTime.now().getDate()}")
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
      await _instance
          .collection(Db.usersCollection)
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
