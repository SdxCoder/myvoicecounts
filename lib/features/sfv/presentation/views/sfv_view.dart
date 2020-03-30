


import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './sfv_view_mobile.dart';
import './sfv_view_tablet.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../view_models/sfv_view_model.dart';

class SfvView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (model) async => await model.getSfvSnapshots(),
      viewModel: SfvViewModel(),
      builder: (context, model, child) =>
          Scaffold(
            
        body: Container(
          decoration: BoxDecoration(
              gradient: gradientHome,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          child: ScreenTypeLayout.builder(
            mobile : (context) => SfvViewMobile(model : model),
         //   tablet: (context) => SfvViewTablet(model : model),
          ),
        )
      ),
    );
  }
}