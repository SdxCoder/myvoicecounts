

import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';
import './data_view_tablet.dart';


class DataCandidateView extends StatelessWidget {
  final Candidate candidate;

  const DataCandidateView({Key key, this.candidate}) : super(key: key);
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