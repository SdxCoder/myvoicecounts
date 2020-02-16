import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './issue_view_mobile.dart';
import './issue_view_tablet.dart';

class IssueView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile :(context) => IssueViewMobile(),
        tablet:(context) => IssueViewTablet()
      ),
    );
  }
}