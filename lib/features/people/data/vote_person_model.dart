

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotePerson {
  final String documentId;
  final String personId;
  final String personName;
  final String adu;
  final DateTime date;
  final String age;
  final String ethnicity;
  final String gender;
  final String party;
  final String race;
  final String state;
 

  VotePerson(
    {
    this.personId,
    this.personName,
    this.adu,
    this.date,
    this.state,
    this.party,
    this.age,
    this.ethnicity,
    this.gender,
    this.race,
    documentId}
  ) : this.documentId = documentId;

  VotePerson.fromMap(Map<String, dynamic> map, ) : 
    personId = map['personId'],
    personName = map['personName'],
    adu = map['adu'],
    date = map['date'],
     ethnicity = map['ethnicity'],
    age = map['age'],
    gender = map['gender'],
    party = map['party'],
    race = map['race'],
    state = map['state'],
    documentId = map['id'];


   Map<String, dynamic> toMap(){
    return {
      'personId' : personId,
      'personName' : personName,
      'adu' : adu,
      'date' : date,
      'id': documentId,
      'ethnicity' : ethnicity,
      'age' : age,
      'gender' : gender,
      'party' : party,
      'race' : race,
      'state' : state,
    };
  }
}
