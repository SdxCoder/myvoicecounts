import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:myvoicecounts/features/settings/services/settings_service.dart';
import 'package:string_validator/string_validator.dart';

import '../../../splash_screen/data/user.dart';

class SettingsViewModel extends BaseModel {
  final _settingsService = Modular.get<SettingsService>();
  final _splashService = Modular.get<SplashService>();
  User _currentUser = Modular.get<SplashService>().currentUser;
  FirebaseUser _firebaseUser;

  User get currentUser => _currentUser;

 // User _updatedUser;

  Future updateUser(Map<String, dynamic> map) async {
    if(await _manageZeroIntegrity() == false) return;
    if (_validateText(map)) return;
    var result = await _settingsService.updateUser(map, _currentUser.id);

    if (result is String) {
      showInfoDialogBox(title: "error", description: result);
    } else {
      showSnackBarInfo(desc: "${map.keys} updated : ${map.values}".replaceAll("(", "").replaceAll(")", ""));
      fetchUpdatedUser().then((value) {
        _manageIntegrity();
      });
    }
  }

  Future fetchUpdatedUser() async {
    _firebaseUser = _splashService.firebaseUser;
    _currentUser = await _settingsService.getUser(_currentUser.id);
    _splashService.setUser(_currentUser);
    //_currentUser = _updatedUser;
    notifyListeners();
  }

  Future<bool> _manageZeroIntegrity() async{
    int integrity = _currentUser.integrity;
      if (integrity == 0) {
       await showActionDialogBox(
            onPressedYes: () {
              _settingsService.deleteUser(_currentUser.id, _firebaseUser);
              Modular.to.pushNamedAndRemoveUntil(Paths.splash, (route) => false);

            },
            onPressedNo: (){
              Modular.to.pop();
            },
            title: "Warning",
            description:
                "You have no edits left, if you edit your all data will be lost. Do you want to continue?");
        
         return false;
      } 
    
     return true;
  }

  void _manageIntegrity() {
    if (_currentUser.gender != null &&
        _currentUser.state != null &&
        _currentUser.city != null &&
        _currentUser.age != null &&
        _currentUser.ethnicity != null &&
        _currentUser.race != null &&
        _currentUser.party != null &&
        _currentUser.zip != null) {
      int integrity = _currentUser.integrity;
     
        _settingsService.updateUser(
            { 
              'isComplete': true,
              'integrity': integrity - 1,
              
            }, _currentUser.id).then((value) {
          fetchUpdatedUser();
        });
      //}
    }
  }

  bool showUpdateReminder() {
    if (_currentUser.gender == null ||
        _currentUser.state == null ||
        _currentUser.city == null ||
        _currentUser.age == null ||
        _currentUser.ethnicity == null ||
        _currentUser.race == null ||
        _currentUser.party == null ||
        _currentUser.zip == null) {
      return true;
      // await showSnackBarInfo(
      //     desc: "Please update all parameters of your profile");
    }else{
      return false;
    }
  }

  void showIntegretyControl() {
    showInfoDialogBox(
        title: "Warning",
        description:
            "You have changed your profile ${3 - currentUser.integrity} times.\n\n You are left with ${currentUser.integrity} edits before your account gets deleted");
  }

  bool _validateText(Map<String, dynamic> map) {
    if (map.containsKey('zip')) {
      String zip = map['zip'];

      if (isNull(zip)) {
        showSnackBarInfo(desc: "Please enter zip code");
        return true;
      }

       if (!isNumeric(zip)) {
        showSnackBarInfo(desc: "Only alphabets are allowed");
        return true;
      }
    }

    if (map.containsKey('city')) {
      String city = map['city'];
      city = city.trim().replaceAll(new RegExp(r"\s+\b|\b\s"), "");

      if (isNull(city)) {
        showSnackBarInfo(desc: "Please enter city");
        return true;
      }

      if (!isAlpha(city)) {
        showSnackBarInfo(desc: "Only alphabets are allowed");
        return true;
      }
    }

    return false;
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
  List<int> age = List<int>.generate(51, (index) => index + 15);

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
