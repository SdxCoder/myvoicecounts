import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/issues/presentation/view_models/issue_view_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './issue_view_mobile.dart';
import './issue_view_tablet.dart';

class IssueView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (IssueViewModel model) => model.fetchUpdatedUser(),
      viewModel: IssueViewModel(),
      builder: (context, model, child) =>
           Scaffold(
        body: ScreenTypeLayout.builder(
          mobile :(context) => IssueViewMobile(model:model),
         // tablet:(context) => IssueViewTablet(model:model)
        ),
      ),
    );
  }
}