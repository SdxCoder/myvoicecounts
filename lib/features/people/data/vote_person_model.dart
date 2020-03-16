

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotePerson {
  final String documentId;
  final String personId;
  final String personName;
  final String adu;
  final String date;
 

  VotePerson(
    {
    this.personId,
    this.personName,
    this.adu,
    this.date,
    documentId}
  ) : this.documentId = documentId;

  VotePerson.fromMap(Map<String, dynamic> map, ) : 
    personId = map['personId'],
    personName = map['personName'],
    adu = map['adu'],
    date = map['date'],
   
    documentId = map['id'];


   Map<String, dynamic> toMap(){
    return {
      'personId' : personId,
      'personName' : personName,
      'adu' : adu,
      'date' : date,
      'id': documentId
    };
  }
}
