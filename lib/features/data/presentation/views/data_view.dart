

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';


class DataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => DataViewMobile(),
       // tablet: (context) => DataViewTablet(),
      ),
    );
  }
}