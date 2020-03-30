import 'package:background_fetch/background_fetch.dart';
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

   BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}


/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  
  print("[BackgroundFetch] Headless event received: $taskId");
  await _updateUser({
        'voteIntegrity' : 3
      });
  BackgroundFetch.finish(taskId);

  // if (taskId == 'flutter_background_fetch') {
  //   BackgroundFetch.scheduleTask(TaskConfig(
  //       taskId: "com.transistorsoft.customtask",
  //       delay: 5000,
  //       periodic: true,
  //       forceAlarmManager: true,
  //       stopOnTerminate: false,
  //       enableHeadless: true
  //   ));
  // }
}

class App extends StatefulWidget {
 

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  void initState() {
    super.initState();
    initPlatformState();
    BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
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

   Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      await _updateUser({
        'voteIntegrity' : 3
      });
    
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      print('[BackgroundFetch] configure success: true');
     
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
     
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    print("[BackgroundFetch Status] $status");

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


}

Future _updateUser(Map<String, dynamic> map) async {
   final prefs = await SharedPreferences.getInstance();
   
        
    try {
      await Firestore.instance.collection(Db.usersCollection)
          .document(prefs.getString('uid'))
          .updateData(map);
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        print(e.message);
        return e.message;
      }
      print(e.toString());
      return e.toString();
    }
  }


