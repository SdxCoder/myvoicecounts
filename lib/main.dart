
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './app_module.dart';
import 'core/core.dart';

void main() {
  runApp(
   DevicePreview(
     enabled: false,
     builder: (context) =>
    ModularApp(module: AppModule()),
    ),
  );

  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}



class App extends StatefulWidget {
 

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
       builder: DevicePreview.appBuilder,
         initialRoute: '/',
         onGenerateRoute: Modular.generateRoute,
         navigatorKey: Modular.navigatorKey,
    );
  }

  
}
