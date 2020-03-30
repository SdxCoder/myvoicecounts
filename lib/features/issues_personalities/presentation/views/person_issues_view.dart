import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/issues/presentation/view_models/issue_view_model.dart';
import 'package:myvoicecounts/features/issues_personalities/presentation/view_models/person_issue_view_model.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './issue_view_mobile.dart';
import './issue_view_tablet.dart';

class PersonIssueView extends StatelessWidget {
  final Candidate candidate;

  PersonIssueView({Key key, this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (PersonIssueViewModel model) {
        model.fetchUpdatedUser();
        model.selectCandidate(candidate);
      } ,
      viewModel: PersonIssueViewModel(),
      builder: (context, model, child) =>
           Scaffold(
        body: ScreenTypeLayout.builder(
          mobile :(context) => IssueViewMobile(model:model, candidate : candidate),
         // tablet:(context) => IssueViewTablet(model:model, candidate : candidate)
        ),
      ),
    );
  }
}