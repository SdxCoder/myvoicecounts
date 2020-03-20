import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String age;
  final String city;
  final String state;
  final String zip;
  final String ethnicity;
  final String gender;
  final String race;
  final String party;
  final int integrity;
  final bool isComplete;
  final voteIntegrity;
  final DateTime lastActive;

  User( {this.lastActive, this.id, this.age, this.city, this.state, this.zip, this.ethnicity,
      this.gender, this.race, this.party, this.integrity,this.isComplete, this.voteIntegrity});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        age = data['age'],
        city = data['city'],
        state = data['state'],
        zip = data['zip'],
        ethnicity = data['ethnicity'],
        gender = data['gender'],
        race = data['race'],
        party = data['party'],
        integrity = data['integrity'],
        isComplete = data['isComplete'],
        lastActive= data['lastActive'].toDate(),
        voteIntegrity = data['voteIntegrity'];

  Map<String, dynamic> toJson() {
   
    return {
      'id': id,
      'age':age,
      'city':city,
      'state': state,
      'zip':zip,
      'ethnicity': ethnicity,
      'gender':gender,
      'race':race,
      'party':party,
      'integrity': integrity,
      'isComplete': isComplete,
      'voteIntegrity': voteIntegrity,
      'lastActive' : lastActive.toUtc()
    };

    
  }
}
