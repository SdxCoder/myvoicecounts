

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';
import './data_view_tablet.dart';


class DataView extends StatelessWidget {
  final Issue issue;

  const DataView({Key key, this.issue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (DataByIssueViewModel model){
     
        model.fetchData(model.selectedPeriod, issue.documentId);
      },
      viewModel: DataByIssueViewModel(),
      builder: (context, model, child)=>
          Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (context) => DataViewMobile(model : model, issue : issue),
        // tablet: (context) => DataViewTablet(model : model, issue : issue),
        ),
      ),
    );
  }
}