

import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';
import './data_view_tablet.dart';


class DataView extends StatelessWidget {
  final Issue issue;

  const DataView({Key key, this.issue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => DataViewMobile(),
       tablet: (context) => DataViewTablet(),
      ),
    );
  }
}