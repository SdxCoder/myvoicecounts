import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';

class DataViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMobile(
      title: Text("Demographics By Issue", style: themeData.textTheme.body1,)
    );
  }
}