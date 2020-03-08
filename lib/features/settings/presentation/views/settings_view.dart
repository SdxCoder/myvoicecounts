


import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './settings_view_mobile.dart';
import './settings_view_tablet.dart';
import '../view_models/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SettingsViewModel>.withConsumer(
      viewModel: SettingsViewModel(),
    //  onModelReady: (model) async => await model.showUpdateReminder(),
      builder: (context, SettingsViewModel model, child)=>
           Scaffold(
        body: ScreenTypeLayout.builder(
          mobile : (context) => SettingsViewMobile(model : model),
          tablet: (context) => SettingsViewTablet(model : model),
        )
      ),
    );
  }
}