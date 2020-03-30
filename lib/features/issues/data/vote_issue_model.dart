import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteIssue {
  final String documentId;
  final String issueId;
  final String issueName;
  final String adu;
  final DateTime date;
  final String age;
  final String ethnicity;
  final String gender;
  final String party;
  final String race;
  final String state;
  final int voteIntegrity;

  VoteIssue(
    {this.issueId,
    this.issueName,
    this.adu,
    this.date,
    this.age,
    this.ethnicity,
    this.gender,
    this.party,
    this.race,
    this.state,
    this.voteIntegrity,
    documentId}
  ) : this.documentId = documentId;

  VoteIssue.fromMap(Map<String, dynamic> map, ) : 
    issueId = map['issueId'],
    issueName = map['issueName'],
    adu = map['adu'],
    date = map['date'],
    ethnicity = map['ethnicity'],
    age = map['age'],
    gender = map['gender'],
    party = map['party'],
    race = map['race'],
    state = map['state'],
    voteIntegrity = map['voteIntegrity'],
    documentId = map['id'];


   Map<String, dynamic> toMap(){
    return {
      'issueId' : issueId,
      'issueName' : issueName,
      'adu' : adu,
      'date' : date,
      'ethnicity' : ethnicity,
      'age' : age,
      'gender' : gender,
      'party' : party,
      'race' : race,
      'state' : state,
      'voteIntegrity': voteIntegrity,
      'id': documentId
    };
  }
}
