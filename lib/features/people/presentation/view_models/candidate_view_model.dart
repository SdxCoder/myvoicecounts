

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/people/services/candidate_service.dart';

class CandidateViewModel extends BaseModel{
  final _candidateService = Modular.get<CandidateService>();

  Candidate _selectedCandidate;
  Candidate get  selectedCandidate => _selectedCandidate;


  void selectCandidate(candidate){
    _selectedCandidate = candidate;
    notifyListeners();
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