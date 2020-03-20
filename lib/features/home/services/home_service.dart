import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/home/data/map_data.dart';

class HomeService {
  Firestore _instance = Firestore.instance;

  List<MapData> dataList = List<MapData>();
  List<String> filteredList = List<String>();
  List<MapData> chosenList = List<MapData>();
  PartyData partyData;

  Future fetchAllVotes() async {
    chosenList = [];
    dataList = [];
    filteredList = [];
    partyData = PartyData();
    try {
      QuerySnapshot snapshot =
          await _instance.collection(Db.personVotesCollection).getDocuments();

      // if (snapshot.documents.isEmpty) {
      //   return false;
      // }

      for (int index = 0; index < snapshot.documents.length; index++) {
        var data = MapData();
        data.state = snapshot.documents[index].data['state'];
        data.party = snapshot.documents[index].data['party'];

        for (int stateIndex = 0; stateIndex < states.length; stateIndex++) {
          if (data.state == states[stateIndex]) {
            data.point = statesLatlng[stateIndex];
          }
        }

        if (snapshot.documents[index].data['party'] == 'Democrat') {
          data.color = Colors.blue;
        }

        if (snapshot.documents[index].data['party'] == 'Independent') {
          data.color = Colors.green;
        }

        if (snapshot.documents[index].data['party'] == 'Republican') {
          data.color = Colors.red;
        }

        if (snapshot.documents[index].data['party'] == 'Other') {
          data.color = Colors.grey;
        }

        dataList.add(data);

        for (var item in dataList) {
          print("-----> ${item.state} - ${item.party}");
          if (filteredList.contains(item.state)) {
            continue;
          } else {
            filteredList.add(item.state);
          }
        }
        print(filteredList.length);
      }

      List<List<MapData>> listSet = [];

      for (var f in filteredList) {
        print(f);
        List<MapData> list = [];
        for (var item in dataList) {
          if (item.state == f) {
            list.add(item);
          }
        }
        listSet.add(list);
      }

      for (var l in listSet) {
        for (var i in l) {
          print("${l.length} - ${i.state}");
        }
      }

      print("list set ${listSet.length}");

      for (var eachList in listSet) {
        int max = 0;
        int maxIndex = 0;
        List<DominantParty> party = [
          DominantParty(data: MapData()),
          DominantParty(data: MapData()),
          DominantParty(data: MapData()),
          DominantParty(data: MapData())
        ];
        for (int i = 0; i < eachList.length; i++) {
          if (eachList[i].party == 'Independent') {
            party[0].counter = party[0].counter + 1;
            party[0].data = eachList[i];
          }

          if (eachList[i].party == 'Republican') {
            party[1].counter = party[1].counter + 1;
            party[1].data = eachList[i];
          }

          if (eachList[i].party == 'Democrat') {
            party[2].counter = party[2].counter + 1;
            party[2].data = eachList[i];
          }

          if (eachList[i].party == 'Other') {
            party[3].counter = party[3].counter + 1;
            party[3].data = eachList[i];
          }
        }

        for (int i = 0; i < party.length; i++) {
          if (party[i].counter > max) {
            max = party[i].counter;
            maxIndex = i;
          }
        }

        chosenList.add(party[maxIndex].data);
      }

      print("Chosen list ${chosenList.length}");
      return chosenList;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future fetchPartyData() async {
    partyData = PartyData(independent: 0, democrat: 0, republic: 0, other: 0);
    int independent = 0;
    int republic = 0;
    int democrat = 0;
    int other = 0;

    try {
      QuerySnapshot snapshot =
          await _instance.collection(Db.personVotesCollection).getDocuments();

      // if (snapshot.documents.isEmpty) {
      //   return false;
      // } else {
      //   partyData.total = snapshot.documents.length;
      // }

      partyData.total = snapshot.documents.length;

      for (int index = 0; index < snapshot.documents.length; index++) {
        if (snapshot.documents[index].data['party'] == 'Democrat') {
          democrat = democrat + 1;
        }

        if (snapshot.documents[index].data['party'] == 'Independent') {
          independent = independent + 1;
        }

        if (snapshot.documents[index].data['party'] == 'Republican') {
          republic = republic + 1;
        }

        if (snapshot.documents[index].data['party'] == 'Other') {
          other = other + 1;
        }
      }

      partyData.independent = independent;
      partyData.republic = republic;
      partyData.other = other;
      partyData.democrat = democrat;

      return partyData;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  MapData chooseMarkersForEachState(MapData data) {}
}
