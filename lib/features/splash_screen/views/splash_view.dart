import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/shared_widgets/dialog_widget.dart';
import 'package:myvoicecounts/features/splash_screen/view_model/splash_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './splash_screen_mobile.dart';
import './splash_screen_tablet.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

   @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //     return HomeView();
    //   }));
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SplashViewModel>.withConsumer(
      viewModel: SplashViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, SplashViewModel model, child)=>
          Scaffold(
          body: ScreenTypeLayout.builder(
            mobile: (context) => SplashScreenMobile(),
            tablet: (context) => SplashScreenTablet(),
          ),
        ),
    );
  }
}