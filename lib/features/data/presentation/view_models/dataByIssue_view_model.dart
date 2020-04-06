

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/services/data_issue_service.dart';

import '../../data/queryData.dart';

class DataByIssueViewModel extends BaseModel{

  final _service = Modular.get<DataIssueService>();

  DatePeriod _selectedPeriod = DatePeriod(DateTime.utc(2020, 3, 1), DateTime.now().toUtc());
  QueryData data;

  bool _noData = false;

  DatePeriod get selectedPeriod => _selectedPeriod;
  bool get noData => _noData;

  void fetchPeriod(period){
    _selectedPeriod = period;
    notifyListeners();
  }

  void resetData(){
    data = null;
  }

  Future fetchData(period, issueId) async {
    resetData();
    setBuzy(true);
    var result = await _service.fetchData(period, issueId);
   if(result is String){
      showSnackBarInfo(desc : result);
    }
    else{
      if(result == false){
        _noData = true;
      }

      if(result is QueryData){ 
         data = result;

         data.agree.calculatePercent(data.total);
         data.disagree.calculatePercent(data.total);
         data.undecided.calculatePercent(data.total);
         _noData = false;  
      }
    }
   setBuzy(false);

   if(data != null){
      print("Group A - ${data.agree.groupA} - ${data.disagree.groupA} - ${data.undecided.groupA}");
   print("Group B - ${data.agree.groupB} - ${data.disagree.groupB} - ${data.undecided.groupB}");
   print("Group C - ${data.agree.groupC} - ${data.disagree.groupC} - ${data.undecided.groupC}");
   print("Group D - ${data.agree.groupD} - ${data.disagree.groupD} - ${data.undecided.groupD}");
   
   print("Not-Hisp - ${data.agree.notHisp} - ${data.disagree.notHisp} - ${data.undecided.notHisp}");
   print("Hisp - ${data.agree.hisp} - ${data.disagree.hisp} - ${data.undecided.hisp}");
   print("Male - ${data.agree.male} - ${data.disagree.male} - ${data.undecided.male}");
   print("Feale - ${data.agree.female} - ${data.disagree.female} - ${data.undecided.female}");
   print("Race asian- ${data.agree.asian} - ${data.disagree.asian} - ${data.undecided.asian}");
   print("Race american- ${data.agree.american} - ${data.disagree.american} - ${data.undecided.american}");
   print("Race african- ${data.agree.african} - ${data.disagree.african} - ${data.undecided.african}");
  print("Race hawaian- ${data.agree.hawaian} - ${data.disagree.hawaian} - ${data.undecided.hawaian}");
  print("Race white- ${data.agree.white} - ${data.disagree.white} - ${data.undecided.white}");
  print("Party democrat- ${data.agree.democrat} - ${data.disagree.democrat} - ${data.undecided.democrat}");
   print("Party republic- ${data.agree.republic} - ${data.disagree.republic} - ${data.undecided.republic}");
    print("Party independent- ${data.agree.independent} - ${data.disagree.independent} - ${data.undecided.independent}");
     print("Party other- ${data.agree.other} - ${data.disagree.other} - ${data.undecided.other}");

    for (var state in data.agree.states){
      print("State agree - ${state.state} - ${state.totalAdu}");
    }

    for (var state in data.disagree.states){
      print("State disagree - ${state.state} - ${state.totalAdu}");
    }

    for (var state in data.undecided.states){
      print("State undecided - ${state.state} - ${state.totalAdu}");
    }

   }
   
  
  }

 

 

}