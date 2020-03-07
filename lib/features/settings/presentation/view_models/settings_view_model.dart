import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:myvoicecounts/features/settings/services/settings_service.dart';

import '../../../splash_screen/data/user.dart';

class SettingsViewModel extends BaseModel {
  final _settingsService = Modular.get<SettingsService>();
  final currentUser = Modular.get<SplashService>().currentUser;

  Future updateUser(user, key, value) async {
    var result = await _settingsService.updateUser(user);

    if (result is String) {
      showInfoDialogBox(title: "error", description: result);
    }
    else{
      showSnackBarInfo(desc: "$key Updated : $value");
    }
  }

  Future manageUpdate({@required String key,@required String value}) async {
    switch (key) {
      case 'State':
        final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: value,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: currentUser.party,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'City':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: value,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: currentUser.party,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'Zip':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: currentUser.party,
          race: currentUser.race,
          zip: value
        );
        updateUser(user, key, value);
        break;
      case 'Age':
       final user = User(
          id: currentUser.id,
          age: value,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: currentUser.party,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'Ethnicity':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: value,
          gender: currentUser.gender,
          party: currentUser.party,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'Gender':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: value,
          party: currentUser.party,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'Race':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: currentUser.party,
          race: value,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
      case 'Party':
       final user = User(
          id: currentUser.id,
          age: currentUser.age,
          state: currentUser.state,
          city: currentUser.city,
          ethnicity: currentUser.ethnicity,
          gender: currentUser.gender,
          party: value,
          race: currentUser.race,
          zip: currentUser.zip
        );
        updateUser(user, key, value);
        break;
    }
  }

  void showIntegretyControl() {
    showInfoDialogBox(
        title: "Integrity Control Alert",
        description:
            "You have already changed your profile twice\n\nYou can share again tomorrow");
  }
}
