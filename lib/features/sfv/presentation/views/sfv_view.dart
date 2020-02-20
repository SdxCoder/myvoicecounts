


import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './sfv_view_mobile.dart';
import './sfv_view_tablet.dart';

class SfvView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile : (context) => SfvViewMobile(),
        tablet: (context) => SfvViewTablet(),
      )
    );
  }
}