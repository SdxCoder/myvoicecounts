


import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './settings_view_mobile.dart';
import './settings_view_tablet.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile : (context) => SettingsViewMobile(),
        tablet: (context) => SettingsViewTablet(),
      )
    );
  }
}