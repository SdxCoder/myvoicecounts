import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/people/presentation/view_models/candidate_view_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './people_view_mobile.dart';
import './people_view_tablet.dart';



class PeopleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (CandidateViewModel model) => model.fetchUpdatedUser(),
      viewModel: CandidateViewModel(),
      builder: (context, model, child)
          => Scaffold(
            body: ScreenTypeLayout.builder(
          mobile: (context) => PeopleViewMobile(model:model),
         // tablet: (context) => PeopleViewTablet(model: model),
        ),
      ),
    );
  }
}