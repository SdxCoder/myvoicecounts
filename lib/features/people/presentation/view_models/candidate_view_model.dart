

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
    if(await _manageVoteIntegrity()) return;
  
    var result  = await _candidateService.addVoteForPerson(VotePerson(
      documentId: _currentUser.id,
       adu: adu,
       date: DateTime.now(),
       personId: candidate.documentId,
       personName: candidate.name
    ), _currentUser.id);

    if(result is String){
      await showInfoDialogBox(title: "Error", description: result);
    }
    else{
      
      _candidateService.updateUser({
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
    if(_selectedCandidate == null){
      await showInfoDialogBox(title: "Reminder", description: "Please, First select a personality for which you want to see the demographics");
    }else{
      Modular.to.pushReplacementNamed(Paths.dataByPersonality, arguments : _selectedCandidate);
    }
   
  }
  
  getCandidatesStream() {
    return _candidateService.getCandidatesStream();
  }

}