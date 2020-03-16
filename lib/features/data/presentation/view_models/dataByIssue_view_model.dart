

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/services/data_issue_service.dart';

import '../../data/queryData.dart';

class DataByIssueViewModel extends BaseModel{

  final _service = Modular.get<DataIssueService>();

  DatePeriod _selectedPeriod;
  QueryData data;

  DatePeriod get selectedPeriod => _selectedPeriod;

  void fetchPeriod(period){
    _selectedPeriod = period;
    notifyListeners();
  }

  Future fetchAduByAgeGroups(period) async {
    var result = await _service.fetchData(period);
   if(result is String){
      showSnackBarInfo(desc : result);
    }
    else{
      if(result == false){
        setBuzy(true);
        return;
      }

      if(result is QueryData){
         data = result;
        
      }
      setBuzy(false);
    }
   
 print(data.agree.age.groupA);
  }

  void _handleResult(result, Function(QueryData) callback){
    
    
  }

}