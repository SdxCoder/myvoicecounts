import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:myvoicecounts/features/settings/services/settings_service.dart';

import '../../../splash_screen/data/user.dart';

class SettingsViewModel extends BaseModel {
  final _settingsService = Modular.get<SettingsService>();
  final _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;

  User get currentUser => _currentUser;

  User _updatedUser;

  Future updateUser(Map<String, dynamic> map) async {
    var result = await _settingsService.updateUser(map, _currentUser.id);

    if (result is String) {
      showInfoDialogBox(title: "error", description: result);
    } else {
      showSnackBarInfo(desc: "${map.keys} Updated : ${map.values}");
      _fetchUpdatedUser().then((value) {
        _manageIntegrity();
      });
    }
  }

  Future _fetchUpdatedUser() async {
    _updatedUser = await _settingsService.getUser(_currentUser.id);
    _splashService.setUser(_updatedUser);
    _currentUser = _updatedUser;
    notifyListeners();
  }

  void _manageIntegrity() async {
    if (_updatedUser.gender != null &&
        _updatedUser.state != null &&
        _updatedUser.city != null &&
        _updatedUser.age != null &&
        _updatedUser.ethnicity != null &&
        _updatedUser.race != null &&
        _updatedUser.party != null &&
        _updatedUser.zip != null) {
      int integrity = _updatedUser.integrity;
      if (integrity == 0) {
        showActionDialogBox(
            onPressed: () {
              _settingsService.deleteUser(_currentUser.id);
            },
            title: "Warning",
            description:
                "You have no edits left, if you edit your all data will be lost");
      } else {
        _settingsService.updateUser(
            {'integrity': integrity - 1}, _currentUser.id).then((value) {
          _fetchUpdatedUser();
        });
      }
    }
  }

  Future showUpdateReminder() async {
    if (_currentUser.gender == null ||
        _currentUser.state == null ||
        _currentUser.city == null ||
        _currentUser.age == null ||
        _currentUser.ethnicity == null ||
        _currentUser.race == null ||
        _currentUser.party == null ||
        _currentUser.zip == null) {
      await showSnackBarInfo(
          desc: "Please update all parameters of your profile");
    }
  }

  void showIntegretyControl() {
    showInfoDialogBox(
        title: "Warning",
        description:
            "You have changed your profile ${3 - currentUser.integrity} times.\n\n You are left with ${currentUser.integrity} edits before your account gets deleted");
  }

  List<String> ethnicity = ["Hispanic or Latino", "Not Hispanic or Latino"];

  List<String> race = [
    "American Indian or Alaska Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or Other Paciﬁc Islander",
    "White"
  ];

  List<String> party = ["Democrat", "Independent", "Republican", "Other"];
   List<String> gender = ["Male", "Female"];

  List<String> allStates = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"
  ];
}
