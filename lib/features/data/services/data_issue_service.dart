import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/core/core.dart';

import '../data/queryData.dart';

class DataIssueService {
  Firestore _instance = Firestore.instance;
  QueryData data;

  Future fetchData(DatePeriod period, String issueId) async {
    data = QueryData(
        agree: QueryDataAgree(),
        disagree: QueryDataDisAgree(),
        undecided: QueryDataUndecided());

    try {
      QuerySnapshot snapshot0 = await _instance
          .collection(Db.issueVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
          .where('date', isLessThanOrEqualTo: period.end.toUtc())
          .where('issueId', isEqualTo: issueId)
          .getDocuments();

      if (snapshot0.documents.isEmpty) {
        return false;
      } else {
        data.total = snapshot0.documents.length;
      }

      await fetchByAgeGroups(period, issueId);
      await fetchByEthnicity(period, issueId);
      await fetchByGender(period, issueId);
      await fetchByRace(period, issueId);
      await fetchByParty(period, issueId);

      return data;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future fetchByAgeGroups(DatePeriod period, String issueId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.issueVotesCollection)
        .where('age', isGreaterThanOrEqualTo: 15)
        .where('age', isLessThanOrEqualTo: 20)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupA = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.issueVotesCollection)
        // .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 15)
        .where('age', isLessThanOrEqualTo: 20)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupA = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.issueVotesCollection)
        //.where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 15)
        .where('age', isLessThanOrEqualTo: 20)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupA = snapshot2.documents.length;

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.issueVotesCollection)
        .where('age', isGreaterThanOrEqualTo: 21)
        .where('age', isLessThanOrEqualTo: 35)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupB = snapshot3.documents.length;

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.issueVotesCollection)
        // .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 21)
        .where('age', isLessThanOrEqualTo: 35)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupB = snapshot4.documents.length;

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.issueVotesCollection)
        //.where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 21)
        .where('age', isLessThanOrEqualTo: 35)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupB = snapshot5.documents.length;

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.issueVotesCollection)
        .where('age', isGreaterThanOrEqualTo: 36)
        .where('age', isLessThanOrEqualTo: 50)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupC = snapshot6.documents.length;

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.issueVotesCollection)
        // .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 36)
        .where('age', isLessThanOrEqualTo: 50)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupC = snapshot7.documents.length;

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.issueVotesCollection)
        //.where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 36)
        .where('age', isLessThanOrEqualTo: 50)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupC = snapshot8.documents.length;

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.issueVotesCollection)
        .where('age', isGreaterThanOrEqualTo: 51)
        .where('age', isLessThanOrEqualTo: 65)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupD = snapshot9.documents.length;

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.issueVotesCollection)
        // .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 51)
        .where('age', isLessThanOrEqualTo: 65)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupD = snapshot10.documents.length;

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.issueVotesCollection)
        //.where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        // .where('date', isLessThan: period.end.toUtc())
        .where('age', isGreaterThanOrEqualTo: 51)
        .where('age', isLessThanOrEqualTo: 65)
        .where('issueId', isEqualTo: issueId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupD = snapshot11.documents.length;
  }

  Future fetchByEthnicity(DatePeriod period, String issueId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.notHisp = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.hisp = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.notHisp = snapshot2.documents.length;

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.hisp = snapshot3.documents.length;

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.notHisp = snapshot4.documents.length;

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.hisp = snapshot5.documents.length;

    return data;
  }

  Future fetchByGender(DatePeriod period, String issueId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.male = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.female = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.male = snapshot2.documents.length;

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.female = snapshot3.documents.length;

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.male = snapshot4.documents.length;

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.female = snapshot5.documents.length;

    return data;
  }

  Future fetchByRace(DatePeriod period, String issueId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.american = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.american = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.american = snapshot2.documents.length;

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.asian = snapshot3.documents.length;

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.asian = snapshot4.documents.length;

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.asian = snapshot5.documents.length;

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.african = snapshot6.documents.length;

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.african = snapshot7.documents.length;

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.african = snapshot8.documents.length;

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.hawaian = snapshot9.documents.length;

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.hawaian = snapshot10.documents.length;

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.hawaian = snapshot11.documents.length;

    QuerySnapshot snapshot12 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.white = snapshot12.documents.length;

    QuerySnapshot snapshot13 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.white = snapshot13.documents.length;

    QuerySnapshot snapshot14 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.white = snapshot14.documents.length;

    return data;
  }

  Future fetchByParty(DatePeriod period, String issueId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.democrat = snapshot.documents.length;

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.democrat = snapshot1.documents.length;

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.democrat = snapshot2.documents.length;

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.independent = snapshot3.documents.length;

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.independent = snapshot4.documents.length;

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.independent = snapshot5.documents.length;

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.republic = snapshot6.documents.length;

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.republic = snapshot7.documents.length;

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.republic = snapshot8.documents.length;

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.other = snapshot9.documents.length;

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.other = snapshot10.documents.length;

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.issueVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('issueId', isEqualTo: issueId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.other = snapshot11.documents.length;
  }
}
