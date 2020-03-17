import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/core/shared_widgets/dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/splash_service.dart';

class SplashViewModel extends BaseModel {
  final SplashService _splashService = Modular.get<SplashService>();

  Future handleStartUpLogic() async {
    final prefs = await SharedPreferences.getInstance();
    
    var result = await _splashService.signInAnonymously();

    if (result is String) {
      await showInfoDialogBox(title: "Error", description: result)
          .then((value) {
        Modular.to.pushReplacementNamed(Paths.splash);
      });
    } else {
      await _checkAccountStatus(result, prefs);
    }
  }

  Future _checkAccountStatus(user, prefs) async {
    var result = await _splashService.checkAccountStatus(user);

    if (result is String) {
      await showInfoDialogBox(
              title: "Error In Account Retrival", description: result)
          .then((value) {
        Modular.to.pushReplacementNamed(Paths.splash);
      });
    } else {
      if (result == true) {
        await showActionDialogBox(
          title: "Account Info",
          buttonText: "Continue",
          onPressedNo: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          onPressedYes: () async {
            if (prefs.containsKey('uid')) {
              if (prefs.getString('uid') != user.uid) {
                await prefs.remove('uid');
                await prefs.setString('uid', user.uid);
              }
            } else {
              await prefs.setString('uid', user.uid);
            }
            Modular.to.pushReplacementNamed(Paths.home);
          },
          description:
              "Your account was deleted. Continue to proceed with new account",
        );
      } else {
        _splashService.addToAccounts(user);

        if (prefs.containsKey('uid')) {
          if (prefs.getString('uid') != user.uid) {
            await prefs.remove('uid');
            await prefs.setString('uid', user.uid);
          }
        } else {
          await prefs.setString('uid', user.uid);
        }

        print(prefs.getString('uid'));
        Modular.to.pushReplacementNamed(Paths.home);
      }
    }
  }
}
