import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/data/vote_issue_model.dart';
import 'package:myvoicecounts/features/issues/services/issues_service.dart';
import 'package:myvoicecounts/features/settings/services/settings_service.dart';
import 'package:myvoicecounts/features/splash_screen/data/user.dart';

class IssueViewModel extends BaseModel {
  final _issueService = Modular.get<IssuesService>();
  final SplashService _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;

  User get currentUser => _currentUser;

  Issue _selectedIssue;
  Issue get selectedIssue => _selectedIssue;

  void selectIssue(issue) {
    _selectedIssue = issue;
    notifyListeners();
  }

  void voteForIssue(Issue issue, String adu) async {
    if (await _manageProfile()) return;
    if (await _manageVoteIntegrity(issue)) return;

    var result = await _issueService.addVoteForIssue(
        VoteIssue(
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
          voteIntegrity: 1
        ),
        );

    if (result is String) {
      await showInfoDialogBox(title: "Error", description: result);
    } else {
     
      await showInfoDialogBox(
          title: "Success", description: "Your Opinion has been recorded");
    }
  }

  Future fetchUpdatedUser() async {
    _currentUser = await _splashService.getUser(_currentUser.id);
    _splashService.setUser(_currentUser);
    notifyListeners();
  }

  Future<bool> _manageVoteIntegrity(Issue issue) async {
    int currentVoteIntegrity =
        await _issueService.getIssueVoteIntegrityByDay(issue.documentId);
    print("vote Integrity - $currentVoteIntegrity");
    if (currentVoteIntegrity <= 0) {
      await showInfoDialogBox(
          title: "Reminder",
          description:
              "You have already voted 2 times.\n\n You can vote again tomorrow");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _manageProfile() async {
    if (!_currentUser.isComplete) {
      await showInfoDialogBox(
          title: "Reminder",
          description:
              "You can't vote untile your profile is complete. Please complete your profile and then continue");
      return true;
    } else {
      return false;
    }
  }

  void navigateToData() async {
    if (_selectedIssue == null) {
      await showInfoDialogBox(
          title: "Reminder",
          description:
              "Please, First select an issue for which you want to see the demographics");
    } else {
      Modular.to
          .pushReplacementNamed(Paths.dataByIssue, arguments: _selectedIssue);
    }
  }

  getIssuesStream() {
    return _issueService.getIssuesStream();
  }
}
