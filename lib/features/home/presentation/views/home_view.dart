

import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/home/presentation/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (model){
        
        model.fetchData();
      } ,
      viewModel: HomeViewModel(),
      builder:(context, model, child) => Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (context) => HomeViewMobile(model : model),
         // tablet: (context) => HomeViewTablet(model : model),
        ),
      ),
    );
  }
}