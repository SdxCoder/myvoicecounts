


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data_by_candidate/data/queryDataPerson.dart';

class DataPersonService {
  Firestore _instance = Firestore.instance;
  QueryDataPerson data;

  Future fetchPersonData(DatePeriod period, String personId) async {
     data = QueryDataPerson(
        agree: QueryDataAgree(states: List<StateData>()),
        disagree: QueryDataDisAgree(states: List<StateData>()),
        undecided: QueryDataUndecided(states: List<StateData>()));

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

       await fetchByAgeGroups(period, personId);
      await fetchByEthnicity(period, personId);
      await fetchByGender(period, personId);
      await fetchByRace(period, personId);
      await fetchByParty(period, personId);
      await fetchByState(period, personId);
     

      return data;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

   Future fetchByState(DatePeriod period, String personId) async {
    List<StateData> statesDataList = [];

    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .getDocuments();
    print(snapshot.documents.length);
    List<String> statesList = [];

    for (var snapshot in snapshot.documents) {
      if (statesList.contains(snapshot.data['state'])) {
        continue;
      } else {
        statesList.add(snapshot.data['state']);
      }
    }

    print("states ${statesList.length}: ${statesList.map((e) => e)}");

    for (var state in statesList) {
      StateData stateData = StateData(totalAdu: 0, state: "s");

      QuerySnapshot snapshotAgree = await _instance
          .collection(Db.personVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
          .where('date', isLessThan: period.end.toUtc())
          .where('state', isEqualTo: state)
          .where('personId', isEqualTo: personId)
          .where('adu', isEqualTo: 'agree')
          .getDocuments();

      QuerySnapshot snapshotDisAgree = await _instance
          .collection(Db.personVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
          .where('date', isLessThan: period.end.toUtc())
          .where('state', isEqualTo: state)
          .where('personId', isEqualTo: personId)
          .where('adu', isEqualTo: 'disagree')
          .getDocuments();

      QuerySnapshot snapshotUnd = await _instance
          .collection(Db.personVotesCollection)
          .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
          .where('date', isLessThan: period.end.toUtc())
          .where('state', isEqualTo: state)
          .where('personId', isEqualTo: personId)
          .where('adu', isEqualTo: 'undecided')
          .getDocuments();

      int total = snapshotAgree.documents.length +
          snapshotDisAgree.documents.length +
          snapshotUnd.documents.length;

      stateData.totalAdu = total.toDouble();
      stateData.state = state;

      statesDataList.add(stateData);
    }

    statesDataList.sort((b, a) => a.totalAdu.compareTo(b.totalAdu));
    for (var state in statesDataList) {
      print("Descending states : ${state.state} - ${state.totalAdu} \n");
    }


      for (var state in statesDataList) {
        int counter = 0;
         if(counter >= 5){
            break;
          }
        QuerySnapshot snapshot = await _instance
            .collection(Db.personVotesCollection)
            .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
            .where('date', isLessThan: period.end.toUtc())
            .where('state', isEqualTo: state.state)
            .where('personId', isEqualTo: personId)
            .where('adu', isEqualTo: 'agree')
            .getDocuments();

        data.agree.states.add(StateData(totalAdu: snapshot.documents.length.toDouble(), state: state.state));

        QuerySnapshot snapshot1 = await _instance
            .collection(Db.personVotesCollection)
            .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
            .where('date', isLessThan: period.end.toUtc())
            .where('state', isEqualTo: state.state)
            .where('personId', isEqualTo: personId)
            .where('adu', isEqualTo: 'disagree')
            .getDocuments();

        data.disagree.states.add(StateData(totalAdu: snapshot1.documents.length.toDouble(), state: state.state));


        QuerySnapshot snapshot2 = await _instance
            .collection(Db.personVotesCollection)
            .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
            .where('date', isLessThan: period.end.toUtc())
            .where('state', isEqualTo: state.state)
            .where('personId', isEqualTo: personId)
            .where('adu', isEqualTo: 'undecided')
            .getDocuments();

        data.undecided.states.add(StateData(totalAdu: snapshot2.documents.length.toDouble(), state: state.state));
        counter++;
      }

      print("queryData agree : ${data.agree.states.map((e) => e.totalAdu)}");
      print("queryData disagree : ${data.disagree.states.map((e) => e.totalAdu)}");
      print("queryData undecided : ${data.undecided.states.map((e) => e.totalAdu)}");


    // print("Top 5 states : ${statesDataList[0].state}  ${statesDataList[0].totalAdu},${statesDataList[0].state}  ${statesDataList[0].totalAdu}");
  }

  Future fetchByAgeGroups(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '15-20')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupA = snapshot.documents.length.toDouble();

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '15-20')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupA = snapshot1.documents.length.toDouble();

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '15-20')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupA = snapshot2.documents.length.toDouble();

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '21-35')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupB = snapshot3.documents.length.toDouble();

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '21-35')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupB = snapshot4.documents.length.toDouble();

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '21-35')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupB = snapshot5.documents.length.toDouble();

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '36-50')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupC = snapshot6.documents.length.toDouble();

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '36-50')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupC = snapshot7.documents.length.toDouble();

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '36-50')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupC = snapshot8.documents.length.toDouble();

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '51-65')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupD = snapshot9.documents.length.toDouble();

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '51-65')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupD = snapshot10.documents.length.toDouble();

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '51-65')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupD = snapshot11.documents.length.toDouble();

    QuerySnapshot snapshot12 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '66-Older')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.groupE = snapshot12.documents.length.toDouble();

    QuerySnapshot snapshot13 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '66-Older')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.groupE = snapshot13.documents.length.toDouble();

    QuerySnapshot snapshot14 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('age', isEqualTo: '66-Older')
        .where('personId', isEqualTo: personId)
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.groupE = snapshot14.documents.length.toDouble();
  }

  Future fetchByEthnicity(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.notHisp = snapshot.documents.length.toDouble();

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.hisp = snapshot1.documents.length.toDouble();

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.notHisp = snapshot2.documents.length.toDouble();

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.hisp = snapshot3.documents.length.toDouble();

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Not Hispanic or Latino')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.notHisp = snapshot4.documents.length.toDouble();

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('ethnicity', isEqualTo: 'Hispanic or Latino')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.hisp = snapshot5.documents.length.toDouble();

    return data;
  }

  Future fetchByGender(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.male = snapshot.documents.length.toDouble();

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.female = snapshot1.documents.length.toDouble();

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.male = snapshot2.documents.length.toDouble();

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.female = snapshot3.documents.length.toDouble();

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Male')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.male = snapshot4.documents.length.toDouble();

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('gender', isEqualTo: 'Female')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.female = snapshot5.documents.length.toDouble();

    return data;
  }

  Future fetchByRace(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.american = snapshot.documents.length.toDouble();

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.american = snapshot1.documents.length.toDouble();

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'American Indian or Alaska Native')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.american = snapshot2.documents.length.toDouble();

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.asian = snapshot3.documents.length.toDouble();

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.asian = snapshot4.documents.length.toDouble();

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: "Asian")
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.asian = snapshot5.documents.length.toDouble();

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.african = snapshot6.documents.length.toDouble();

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.african = snapshot7.documents.length.toDouble();

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Black or African American')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.african = snapshot8.documents.length.toDouble();

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.hawaian = snapshot9.documents.length.toDouble();

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.hawaian = snapshot10.documents.length.toDouble();

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'Native Hawaiian or Other Paciﬁc Islander')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.hawaian = snapshot11.documents.length.toDouble();

    QuerySnapshot snapshot12 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.white = snapshot12.documents.length.toDouble();

    QuerySnapshot snapshot13 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.white = snapshot13.documents.length.toDouble();

    QuerySnapshot snapshot14 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('race', isEqualTo: 'White')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.white = snapshot14.documents.length.toDouble();

    return data;
  }

  Future fetchByParty(DatePeriod period, String personId) async {
    QuerySnapshot snapshot = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.democrat = snapshot.documents.length.toDouble();

    QuerySnapshot snapshot1 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.democrat = snapshot1.documents.length.toDouble();

    QuerySnapshot snapshot2 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Democrat')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.democrat = snapshot2.documents.length.toDouble();

    QuerySnapshot snapshot3 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.independent = snapshot3.documents.length.toDouble();

    QuerySnapshot snapshot4 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.independent = snapshot4.documents.length.toDouble();

    QuerySnapshot snapshot5 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Independent')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.independent = snapshot5.documents.length.toDouble();

    QuerySnapshot snapshot6 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.republic = snapshot6.documents.length.toDouble();

    QuerySnapshot snapshot7 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.republic = snapshot7.documents.length.toDouble();

    QuerySnapshot snapshot8 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Republican')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.republic = snapshot8.documents.length.toDouble();

    QuerySnapshot snapshot9 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'agree')
        .getDocuments();

    data.agree.other = snapshot9.documents.length.toDouble();

    QuerySnapshot snapshot10 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'disagree')
        .getDocuments();

    data.disagree.other = snapshot10.documents.length.toDouble();

    QuerySnapshot snapshot11 = await _instance
        .collection(Db.personVotesCollection)
        .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
        .where('date', isLessThan: period.end.toUtc())
        .where('personId', isEqualTo: personId)
        .where('party', isEqualTo: 'Other')
        .where('adu', isEqualTo: 'undecided')
        .getDocuments();

    data.undecided.other = snapshot11.documents.length.toDouble();
  }

  
  // Future fetchPersonByVotes(DatePeriod period, String personId) async {
  //   QuerySnapshot snapshot = await _instance
  //       .collection(Db.personVotesCollection)
  //       .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
  //       .where('date', isLessThanOrEqualTo: period.end.toUtc())
  //       .where('personId', isEqualTo: personId)
  //       .where('adu', isEqualTo: 'agree')
  //       .getDocuments();
    
  //   data.agree = snapshot.documents.length;

  //   QuerySnapshot snapshot1 = await _instance
  //       .collection(Db.personVotesCollection)
  //       .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
  //       .where('date', isLessThanOrEqualTo: period.end.toUtc())
  //       .where('personId', isEqualTo: personId)
  //       .where('adu', isEqualTo: 'disagree')
  //       .getDocuments();
    
  //   data.disagree = snapshot1.documents.length;

  //   QuerySnapshot snapshot2 = await _instance
  //       .collection(Db.personVotesCollection)
  //       .where('date', isGreaterThanOrEqualTo: period.start.toUtc())
  //       .where('date', isLessThanOrEqualTo: period.end.toUtc())
  //       .where('personId', isEqualTo: personId)
  //       .where('adu', isEqualTo: 'undecided')
  //       .getDocuments();
    
  //   data.undecided = snapshot2.documents.length;
  // }

}