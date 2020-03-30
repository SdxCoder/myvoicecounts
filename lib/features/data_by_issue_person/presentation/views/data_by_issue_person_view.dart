

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/data/person_issue_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/presentation/view_models/dataByPerson_Issue_view_model.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';
import './data_view_tablet.dart';


class DataByIssuePersonView extends StatelessWidget {
  final PersonIssueObject personIssueObject;

  const DataByIssuePersonView({Key key, this.personIssueObject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (DataByPersonIssueViewModel model){
     
        model.fetchData(model.selectedPeriod, personIssueObject.issue.documentId,  personIssueObject.candidate.documentId);
      },
      viewModel: DataByPersonIssueViewModel(),
      builder: (context, model, child)=>
          Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (context) => DataViewMobile(model : model, personIssueObject : personIssueObject),
         tablet: (context) => DataViewTablet(model : model, personIssueObject : personIssueObject),
        ),
      ),
    );
  }
}