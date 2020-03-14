

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/services/issues_service.dart';

class IssueViewModel extends BaseModel{
  final _issueService = Modular.get<IssuesService>();

  Issue _selectedIssue;
  Issue get  selectedIssue => _selectedIssue;


  void selectIssue(issue){
    _selectedIssue = issue;
    notifyListeners();
  }

  void navigateToData() async{
    if(_selectedIssue == null){
      await showInfoDialogBox(title: "Reminder", description: "Please, First select an issue for which you want to see the demographics");
    }else{
      Modular.to.pushReplacementNamed(Paths.dataByIssue, arguments : _selectedIssue);
    }
  }

  getIssuesStream(){
    return _issueService.getIssuesStream();
  }


}