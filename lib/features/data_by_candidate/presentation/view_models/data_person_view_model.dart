
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data_by_candidate/data/queryDataPerson.dart';
import 'package:myvoicecounts/features/data_by_candidate/services/data_person_service.dart';

class DataByPersonViewModel extends BaseModel{

  final _service = Modular.get<DataPersonService>();

  DatePeriod _selectedPeriod =  DatePeriod(DateTime.utc(2020, 3, 1), DateTime.now().toUtc());
  QueryDataPerson data;

  bool _noData = false;

  DatePeriod get selectedPeriod => _selectedPeriod;
  bool get noData => _noData;

  void fetchPeriod(period){
    _selectedPeriod = period;
    notifyListeners();
  }

  Future fetchData(period, personId) async {
    setBuzy(true);
    var result = await _service.fetchPersonData(period, personId);
   if(result is String){
      showSnackBarInfo(desc : result);
    }
    else{
      if(result == false){
        _noData = true;
      }

      if(result is QueryDataPerson){ 
        data = result;
        if(result.agree == 0 && result.disagree== 0 && result.undecided == 0){
          _noData = true;
        }else{
          
          // data.calculatePercent(data.total);
          _noData = false;  
        }
        
      }
      
    }
   setBuzy(false);

   if(data != null){
      print("Person - ${data.agree} - ${data.disagree} - ${data.undecided}");
   }
   
  
  }

 

}