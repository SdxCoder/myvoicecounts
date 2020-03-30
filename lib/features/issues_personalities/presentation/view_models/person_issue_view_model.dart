

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data_by_issue_person/data/person_issue_model.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/data/vote_issue_model.dart';
import 'package:myvoicecounts/features/issues_personalities/data/vote_person_issue_model.dart';

import 'package:myvoicecounts/features/issues_personalities/services/person_issues_service.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';

class PersonIssueViewModel extends BaseModel{
  final _personIssueService = Modular.get<PersonIssuesService>();
  final SplashService _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;
  
   
   User get currentUser => _currentUser;

  Issue _selectedIssue;
  Candidate _selectedCandidate;
  Issue get  selectedIssue => _selectedIssue;
  // Candidate get  selectedCandidate => _selectedCandidate;

  void selectIssue(issue){
    _selectedIssue = issue;
    notifyListeners();
  }

  void selectCandidate(candidate){
    _selectedCandidate = candidate;
     notifyListeners();
  }

  void voteForPersonIssue(Issue issue, Candidate candidate, String adu) async{

    if(await _manageProfile()) return;
    if(await _manageVoteIntegrity()) return;
  
    var result  = await _personIssueService.addVoteForPersonIssue(VotePersonIssue(
       documentId: _currentUser.id,
       age: _currentUser.age,
       ethnicity: _currentUser.ethnicity,
       gender: _currentUser.gender,
       party: _currentUser.party,
       race: _currentUser.race,
       state: _currentUser.state,
       adu: adu,
       date: DateTime.now().toUtc(),
       issueId: issue.documentId,
       issueName: issue.issueName,
       personId: candidate.documentId,
       personName: candidate.name
    ), _currentUser.id);

    if(result is String){
      await showInfoDialogBox(title: "Error", description: result);
    }
    else{
      
      _personIssueService.updateUser({
        'voteIntegrity' : _currentUser.voteIntegrity - 1,
      }, _currentUser.id).then((value) {
        fetchUpdatedUser();
      });
      await showInfoDialogBox(title: "Success", description : "Your Opinion has been recorded");
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
      await showInfoDialogBox(title: "Reminder", description: "Please, First select an issue for which you want to see the demographics for selected personality");
    }else{
      Modular.to.pushReplacementNamed(Paths.dataByPersonIssue, arguments : PersonIssueObject(
        issue : _selectedIssue,
        candidate : _selectedCandidate
      ));
    }
  }

  getIssuesStream(){
    return _personIssueService.getIssuesStream();
  }


}
