

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => HomeViewMobile(),
        tablet: (context) => HomeViewTablet(),
      ),
    );
  }
}