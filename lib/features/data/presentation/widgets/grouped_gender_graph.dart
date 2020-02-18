import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';

class GroupedGenderGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedGenderGraph(this.seriesList, {this.animate});

  factory GroupedGenderGraph.withTopAgeData() {
    return new GroupedGenderGraph(
      _createGenderData(),
      // Disable animations for image tests.
      animate: true,

    );
  }

  factory GroupedGenderGraph.withGenderData() {
    return new GroupedGenderGraph(
      _createGenderData(),
      // Disable animations for image tests.
      animate: true,

    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,

    );
  }

    /// Create series list with multiple series
  static List<charts.Series<OrdinalAgeAdu, String>> _createGenderData() {
    final agreed = [
      new OrdinalAgeAdu('males', 5),
      new OrdinalAgeAdu('females', 25),
     
    ];

    final disagreed = [
     new OrdinalAgeAdu('males', 35),
      new OrdinalAgeAdu('females', 100),
    ];

    final undecided = [
       new OrdinalAgeAdu('males', 25),
      new OrdinalAgeAdu('females', 75),
    ];


    return [
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalAgeAdu sales, _) => sales.gender,
        measureFn: (OrdinalAgeAdu sales, _) => sales.adu,

        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.primaryColor) ,
        data: agreed,
      ),
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'disagreed',
         displayName: "Agreed",
        domainFn: (OrdinalAgeAdu sales, _) => sales.gender,
        measureFn: (OrdinalAgeAdu sales, _) => sales.adu,
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.accentColor) ,
        data: disagreed,
      ),
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'undecided',
         displayName: "Agreed",
        domainFn: (OrdinalAgeAdu sales, _) => sales.gender,
        measureFn: (OrdinalAgeAdu sales, _) => sales.adu,
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(Colors.white) ,
        data: undecided,
      ),
    ];
  }
}

/// Sample ordinal data type.


class OrdinalAgeAdu{
  final String gender;
  final int adu;

  OrdinalAgeAdu(this.gender, this.adu);

}