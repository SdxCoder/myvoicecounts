

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/core/shared_widgets/dialog_widget.dart';
import '../services/splash_service.dart';

class SplashViewModel extends BaseModel{
  final SplashService _splashService = Modular.get<SplashService>();


  Future handleStartUpLogic() async {
    var result = await _splashService.signInAnonymously();

    if (result is String) {
       showInfoDialogBox(title: "Error", description : result ).then((value) {
          Modular.to.pushReplacementNamed(Paths.splash);
       });
      
    } else {
       Modular.to.pushReplacementNamed(Paths.home);
    }
  }
}