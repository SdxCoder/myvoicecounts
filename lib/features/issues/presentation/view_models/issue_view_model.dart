

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/data/vote_issue_model.dart';
import 'package:myvoicecounts/features/issues/services/issues_service.dart';
import 'package:myvoicecounts/features/settings/services/settings_service.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';

class IssueViewModel extends BaseModel{
  final _issueService = Modular.get<IssuesService>();
  final SplashService _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;
  
   
   User get currentUser => _currentUser;

  Issue _selectedIssue;
  Issue get  selectedIssue => _selectedIssue;


  void selectIssue(issue){
    _selectedIssue = issue;
    notifyListeners();
  }

  void voteForIssue(Issue issue, String adu) async{

    if(await _manageProfile()) return;
    if(await _manageVoteIntegrity()) return;
  
    var result  = await _issueService.addVoteForIssue(VoteIssue(
      documentId: _currentUser.id,
       age: _currentUser.age,
       ethnicity: _currentUser.ethnicity,
       gender: _currentUser.gender,
       party: _currentUser.party,
       race: _currentUser.race,
       adu: adu,
       date: DateTime.now().getDate(),
       issueId: issue.documentId,
       issueName: issue.issueName
    ), _currentUser.id);

    if(result is String){
      await showInfoDialogBox(title: "Error", description: result);
    }
    else{
      
      _issueService.updateUser({
        'voteIntegrity' : _currentUser.voteIntegrity - 1,
      }, _currentUser.id).then((value) {
        fetchUpdatedUser();
      });
      showSnackBarInfo(desc : "Your vote has been submitted");
    }
  }

  Future fetchUpdatedUser() async {
    _currentUser = await _splashService.getUser(_currentUser.id);
    _splashService.setUser(_currentUser);
    //_currentUser = _updatedUser;
    notifyListeners();
  }

  Future<bool> _manageVoteIntegrity() async{
    if(_currentUser.voteIntegrity <= 0){
      await showInfoDialogBox(title: "Reminder", description: "You have already voted ${3 - _currentUser.voteIntegrity} times.\n\n You can vote again tomorrow");
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> _manageProfile() async {
    if(!_currentUser.isComplete){
      await showInfoDialogBox(title: "Reminder", description: "You can't vote untile your profile is complete. Please complete your profile and then continue");
      return true;
    }
    else{
      return false;
    }
   
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