import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';

class GroupedTopAgeGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedTopAgeGraph(this.seriesList, {this.animate});

  factory GroupedTopAgeGraph.withTopAgeData() {
    return new GroupedTopAgeGraph(
      _createTopAgeData(),
      // Disable animations for image tests.
      animate: true,

    );
  }

  factory GroupedTopAgeGraph.withGenderData() {
    return new GroupedTopAgeGraph(
      _createTopAgeData(),
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
  static List<charts.Series<OrdinalAdu, String>> _createTopAgeData() {
    final agreed = [
      new OrdinalAdu('15-20', 5),
      new OrdinalAdu('21-35', 25),
      new OrdinalAdu('36-50', 100),
      new OrdinalAdu('51-65', 75),
    ];

    final disagreed = [
      new OrdinalAdu('15-20', 25),
      new OrdinalAdu('21-35', 50),
      new OrdinalAdu('36-50', 10),
      new OrdinalAdu('51-65', 20),
    ];

    final undecided = [
       new OrdinalAdu('15-20', 45),
      new OrdinalAdu('21-35', 15),
      new OrdinalAdu('36-50', 25),
      new OrdinalAdu('51-65', 45),
    ];


    return [
      new charts.Series<OrdinalAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalAdu sales, _) => sales.age,
        measureFn: (OrdinalAdu sales, _) => sales.adu,
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.primaryColor) ,
        
        data: agreed,
      ),
      new charts.Series<OrdinalAdu, String>(
        id: 'disagreed',
         displayName: "Agreed",
        domainFn: (OrdinalAdu sales, _) => sales.age,
        measureFn: (OrdinalAdu sales, _) => sales.adu,
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.accentColor) ,
        data: disagreed,
      ),
      new charts.Series<OrdinalAdu, String>(
        id: 'undecided',
         displayName: "Agreed",
        domainFn: (OrdinalAdu sales, _) => sales.age,
        measureFn: (OrdinalAdu sales, _) => sales.adu,
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(Colors.white) ,
        data: undecided,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalAdu {
  final String age;
  final int adu;

  OrdinalAdu(this.age, this.adu);
}
