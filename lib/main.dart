import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:device_preview/device_preview.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'core/core.dart';
import 'features/home/home.dart';
import 'splash_screen/splash_screen_mobile.dart';
import 'splash_screen/splash_screen_tablet.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MaterialApp(
        locale: DevicePreview.of(context).locale,
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return HomeView();
        })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => SplashScreenMobile(),
        tablet: (context) => SplashScreenTablet(),
      ),
    );
  }
}
