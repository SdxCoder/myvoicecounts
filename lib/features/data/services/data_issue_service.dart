import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/core/core.dart';

import '../data/queryData.dart';

class DataIssueService {
  Firestore _instance = Firestore.instance;


  
  Future fetchData(DatePeriod period) async {
     QueryData data = QueryData();

    try {
       QuerySnapshot snapshot0 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThanOrEqualTo: period.end)
          .getDocuments();

      if(snapshot0.documents.isEmpty) {
        return false;
      }

      data = await fetchAgreeByAgeGroups(period, data);
      data = await fetchAgreeByEthnicity(period, data);



      return data;
      
    } catch (e) {
      print(e);
      return e.toString();
    }
  }





  Future fetchAgreeByAgeGroups(DatePeriod period, QueryData data) async {

      QuerySnapshot snapshot = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('age', isEqualTo: 15)
        // .where('age', isLessThanOrEqualTo: 20)
          .where('adu', isEqualTo: 'agree')
          .getDocuments();

      data = QueryData(agree: QueryDataAgree(age: Age(groupA : snapshot.documents.length)));

      //  QuerySnapshot snapshot2 = await _instance
      //     .collection(Db.issueVotesCollection)
      //     .where('date', isGreaterThanOrEqualTo: period.start)
      //     .where('date', isLessThanOrEqualTo: period.end)
      //     .where('age', isGreaterThanOrEqualTo: 21)
      //     .where('age', isLessThanOrEqualTo: 35)
      //     .getDocuments();

      //    map.addEntries(
      //       [MapEntry<String, int>('21-35', snapshot2.documents.length)]);

     

      //  QuerySnapshot snapshot3 = await _instance
      //     .collection(Db.issueVotesCollection)
      //     .where('date', isGreaterThanOrEqualTo: period.start)
      //     .where('date', isLessThanOrEqualTo: period.end)
      //     .where('age', isGreaterThanOrEqualTo: 36)
      //     .where('age', isLessThanOrEqualTo: 50)
      //     .getDocuments();
        
      //    map.addEntries(
      //       [MapEntry<String, int>('36-50', snapshot3.documents.length)]);


      //  QuerySnapshot snapshot4 = await _instance
      //     .collection(Db.issueVotesCollection)
      //     .where('date', isGreaterThanOrEqualTo: period.start)
          
      //     .where('date', isLessThanOrEqualTo: period.end)
      //     .where('age', isGreaterThanOrEqualTo: 51)
      //     .where('age', isLessThanOrEqualTo: 65)
      //     .getDocuments();
        
      //    map.addEntries(
      //       [MapEntry<String, int>('51-65', snapshot4.documents.length)]);

      return data;

  }

  
  Future fetchAgreeByEthnicity(DatePeriod period, QueryData data) async {
 

  
      
      QuerySnapshot snapshot = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
          .where('adu', isEqualTo: 'agree')
          .getDocuments();

      data = QueryData(agree: QueryDataAgree(
        ethnicity: Ethnicity(notHisp: snapshot.documents.length)
      ));

      QuerySnapshot snapshot1 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Hispanic or Latino')
          .where('adu', isEqualTo: 'agree')
          .getDocuments();

      data = QueryData(agree: QueryDataAgree(
        ethnicity: Ethnicity(hisp: snapshot1.documents.length)
      ));

      QuerySnapshot snapshot2 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
          .where('adu', isEqualTo: 'disagree')
          .getDocuments();

      data = QueryData(disagree: QueryDataDisAgree(
        ethnicity: Ethnicity(notHisp: snapshot2.documents.length)
      ));

      QuerySnapshot snapshot3 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Hispanic or Latino')
          .where('adu', isEqualTo: 'disagree')
          .getDocuments();

      data = QueryData(disagree: QueryDataDisAgree(
        ethnicity: Ethnicity(hisp: snapshot3.documents.length)
      ));

       QuerySnapshot snapshot4 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
          .where('adu', isEqualTo: 'undecided')
          .getDocuments();

      data = QueryData(disagree: QueryDataDisAgree(
        ethnicity: Ethnicity(notHisp: snapshot4.documents.length)
      ));

      QuerySnapshot snapshot5 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start)
          .where('date', isLessThan: period.end)
          .where('ethnicity', isEqualTo: 'Hispanic or Latino')
          .where('adu', isEqualTo: 'undecided')
          .getDocuments();

      data = QueryData(disagree: QueryDataDisAgree(
        ethnicity: Ethnicity(hisp: snapshot5.documents.length)
      ));

      return data;
  }
}
