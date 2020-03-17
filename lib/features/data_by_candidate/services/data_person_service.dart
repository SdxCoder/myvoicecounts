


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data_by_candidate/data/queryDataPerson.dart';

class DataPersonService {
  Firestore _instance = Firestore.instance;
  QueryDataPerson data;

  Future fetchPersonData(DatePeriod period, String personId) async {
    data = QueryDataPerson();

    try {
      QuerySnapshot snapshot0 = await _instance
          .collection(Db.personVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
          .where('date', isLessThanOrEqualTo: period.end.toUtc())
          .where('personId', isEqualTo: personId)
          .getDocuments();

      if (snapshot0.documents.isEmpty) {
        return false;
      } else {
        data.total = snapshot0.documents.length;
      }

      await fetchPersonByVotes(period, personId);
     

      return data;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  
  Future fetchPersonByVotes(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThanOrEqualTo: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();
    
    data.agree = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThanOrEqualTo: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();
    
    data.disagree = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThanOrEqualTo: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();
    
    data.undecided = snapshot2.documents.length;
  }

}