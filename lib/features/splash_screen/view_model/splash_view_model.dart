import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/core/shared_widgets/dialog_widget.dart';
import '../services/splash_service.dart';

class SplashViewModel extends BaseModel {
  final SplashService _splashService = Modular.get<SplashService>();

  Future handleStartUpLogic() async {
    var result = await _splashService.signInAnonymously();

    if (result is String) {
      await showInfoDialogBox(title: "Error", description: result).then((value) {
        Modular.to.pushReplacementNamed(Paths.splash);
      });
    } else {
      await _checkAccountStatus(result);
    }
  }

  Future _checkAccountStatus(user) async {
    var result = await _splashService.checkAccountStatus(user);

    if (result is String) {
      await showInfoDialogBox(title: "Error In Account Retrival", description: result)
          .then((value) {
        Modular.to.pushReplacementNamed(Paths.splash);
      });
    } else {
      if (result == true) {
        await showActionDialogBox(
          title: "Account Info",
          buttonText: "Continue",
          onPressedNo: (){
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          onPressedYes: (){
            _splashService.addToAccounts(user);
            Modular.to.pushReplacementNamed(Paths.home);
          },
          description:
              "Your account was deleted. Continue to proceed with new account",
        );
      }
      else{
        _splashService.addToAccounts(user);
        Modular.to.pushReplacementNamed(Paths.home);
      }
    }
  }
}
