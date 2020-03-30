

import 'package:flutter/material.dart';
import 'package:myvoicecounts/features/data_by_candidate/presentation/view_models/data_person_view_model.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './data_view_mobile.dart';
import './data_view_tablet.dart';


class DataCandidateView extends StatelessWidget {
  final Candidate candidate;

  const DataCandidateView({Key key, this.candidate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (DataByPersonViewModel model){
        model.fetchData(model.selectedPeriod, candidate.documentId);
      },
      viewModel: DataByPersonViewModel(),
      builder: (context, model, child)=>
           Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (context) => DataViewMobile(model : model, candidate : candidate),
         // tablet: (context) => DataViewTablet(model : model, candidate : candidate),
        ),
      ),
    );
  }
}