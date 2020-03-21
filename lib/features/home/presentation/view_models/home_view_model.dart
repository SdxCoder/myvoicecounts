import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/home/data/map_data.dart';
import 'package:myvoicecounts/features/home/services/home_service.dart';

class HomeViewModel extends BaseModel {
  final _service = Modular.get<HomeService>();

  List<MapData> data;
  PartyData partyData;

  bool _noData = false;

  bool get noData => _noData;

  Future fetchData() async {
    data = [];
    setBuzy(true);
    var result = await _service.fetchAllVotes();
    if (result is String) {
      showSnackBarInfo(desc: result);
    } else {
      // if (result == false) {
      //   _noData = true;
      // }

      if (result is List<MapData>) {
        data = result;
        await fetchPartyData();
        // _noData = false;
      }
    }
    setBuzy(false);

    if (data != null) {
      for (var dataItem in data) {
        print(
            "Map Data -${dataItem.point} ${dataItem.party} - ${dataItem.color.toString()} - ${dataItem.state}");
      }
    }
  }

  Future fetchPartyData() async {
    setBuzy(true);
    var result = await _service.fetchPartyData();
    if (result is String) {
      showSnackBarInfo(desc: result);
    } else {
      if (result is PartyData) {
        partyData = result;
        if(partyData.total != 0){
          partyData.calculatePercent(partyData.total);
        }
       
      }
    }
    setBuzy(false);

    if (data != null) {
      print("Independent - ${partyData.independent}");
      print("democrat - ${partyData.democrat}");
      print("republic - ${partyData.republic}");
      print("other - ${partyData.other}");
    }
  }

}
