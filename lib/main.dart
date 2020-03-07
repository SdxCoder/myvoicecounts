import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app_module.dart';

void main() {
  runApp(
    // DevicePreview(
    //  builder: (context) =>
    ModularApp(module: AppModule()),
    //),
  );
}

class App extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
         initialRoute: '/',
         onGenerateRoute: Modular.generateRoute,
         navigatorKey: Modular.navigatorKey,
    );
  }
}
