

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotePerson {
  final String documentId;
  final String personId;
  final String personName;
  final String adu;
  final DateTime date;
  final String state;
  final String party;
 

  VotePerson(
    {
    this.personId,
    this.personName,
    this.adu,
    this.date,
    this.state,
    this.party,
    documentId}
  ) : this.documentId = documentId;

  VotePerson.fromMap(Map<String, dynamic> map, ) : 
    personId = map['personId'],
    personName = map['personName'],
    adu = map['adu'],
    date = map['date'],
    state = map['state'],
    party = map['party'],
    documentId = map['id'];


   Map<String, dynamic> toMap(){
    return {
      'personId' : personId,
      'personName' : personName,
      'adu' : adu,
      'date' : date,
      'id': documentId,
      'state' : state,
      'party':party
    };
  }
}
