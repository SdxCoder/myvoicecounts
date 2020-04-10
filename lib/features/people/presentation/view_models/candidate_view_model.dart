

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/people/services/candidate_service.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';
import '../../data/vote_person_model.dart';

class CandidateViewModel extends BaseModel{
  final _candidateService = Modular.get<CandidateService>();
  final SplashService _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;
  
   
   User get currentUser => _currentUser;


  Candidate _selectedCandidate;
  Candidate get  selectedCandidate => _selectedCandidate;


  void selectCandidate(candidate){
    _selectedCandidate = candidate;
    notifyListeners();
  }

   void voteForPerson(Candidate candidate, String adu) async{

    if(await _manageProfile()) return;
    if(await _manageVoteIntegrity(candidate)) return;
  
    var result  = await _candidateService.addVoteForPerson(VotePerson(
      documentId: _currentUser.id,
       age: _currentUser.age,
       ethnicity: _currentUser.ethnicity,
       gender: _currentUser.gender,
       party: _currentUser.party,
       race: _currentUser.race,
       state: _currentUser.state,
       adu: adu,
       date: DateTime.now(),
       personId: candidate.documentId,
       personName: candidate.name,
       voteIntegrity: 1
    ),);

    if(result is String){
      await showInfoDialogBox(title: "Error", description: result);
    }
    else{
     
     await showInfoDialogBox(title: "Success", description : "Your Opinion has been recorded");
      await _candidateService.updateUser({
          'lastActive' : DateTime.now().toUtc()
      }, _currentUser.id);

    }
  }
  
  Future fetchUpdatedUser() async {
    _currentUser = await _splashService.getUser(_currentUser.id);
    _splashService.setUser(_currentUser);
    notifyListeners();
  }

  Future<bool> _manageVoteIntegrity(Candidate candidate) async{
    int currentVoteIntegrity =
        await _candidateService.getPersonVoteIntegrityByDay(_currentUser.id,candidate.documentId);
    
    if(currentVoteIntegrity <= 0){
      await showInfoDialogBox(title: "Reminder", description: "You have already given opinion 2 times.\n\n You can upload an opinion again tomorrow");
      return true;
    }
    else{
      return false;
    }
  }

   Future<bool> _manageProfile() async {
    if(!_currentUser.isComplete){
      await showInfoDialogBox(title: "Reminder", description: "You can't upload an opinion until your profile is complete. Please tap the Settings button to do so. Thank you");
      return true;
    }
    else{
      return false;
    }
   
  }

  void navigateToData() async{
    if(_selectedCandidate == null){
      await showInfoDialogBox(title: "Reminder", description: "To see the demographics, please select a personality");
    }else{
      Modular.to.pushReplacementNamed(Paths.dataByPersonality, arguments : _selectedCandidate);
    }
   
  }

   void navigateToPersonIssue() async{
    if(_selectedCandidate == null){
      await showInfoDialogBox(title: "Reminder", description: "To see the issues, please select a personality");
    }else{
      Modular.to.pushReplacementNamed(Paths.personIssues, arguments : _selectedCandidate);
    }
   
  }
  
  getCandidatesStream() {
    return _candidateService.getCandidatesStream();
  }

}