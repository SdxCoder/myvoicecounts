import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/presentation/view_models/dataByPerson_Issue_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedTopStateGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedTopStateGraph(this.seriesList,
      {this.animate, this.sizingInfo});

  // factory GroupedTopAgeGraph.withTopAgeData(sizingInfo, model) {
  //   return new GroupedTopAgeGraph(
  //     _createTopAgeData(),
  //     // Disable animations for image tests.
  //     sizingInfo: sizingInfo,
  //     model: model,
  //     animate: false,
  //   );
  // }

  GroupedTopStateGraph.withTopStateData(sizingInfo, seriesList)
      : sizingInfo = sizingInfo,
        animate = false,
        seriesList = seriesList
      ;

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        // new charts.PercentInjector( 
        //     totalType: charts.PercentInjectorTotalType.domain)
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.

          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width <= 600)
                  ? (sizingInfo.screenSize.width * 0.02).toInt()
                  : (sizingInfo.screenSize.height * 0.02)
                      .toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          lineStyle: charts.LineStyleSpec(
              thickness: 0,
              color: charts.ColorUtil.fromDartColor(Colors.white)),
          labelOffsetFromAxisPx: 16,
          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width <= 600)
                  ? (sizingInfo.screenSize.width * 0.02).toInt()
                  : (sizingInfo.screenSize.height * 0.02)
                      .toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
    );
  }

  /// Create series list with multiple series
}

 List<charts.Series<OrdinalStateAdu, String>> createTopStateData(DataByPersonIssueViewModel model) {
    List<OrdinalStateAdu> agreed = [];

    for(var state in model.data.agree.states){
       agreed.add(OrdinalStateAdu(state.state, state.totalAdu));
    }

    List<OrdinalStateAdu> disagreed = [];

    for(var state in model.data.disagree.states){
       disagreed.add(OrdinalStateAdu(state.state, state.totalAdu));
    }

    List<OrdinalStateAdu> undecided = [];

     for(var state in model.data.undecided.states){
       undecided.add(OrdinalStateAdu(state.state, state.totalAdu));
    }

    // List<OrdinalAdu> total = [
    //   OrdinalAdu("", 100.0)
    // ];

    return [
      new charts.Series<OrdinalStateAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalStateAdu adu, _) => adu.age,
        measureFn: (OrdinalStateAdu adu, _) => adu.adu,
        
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.primaryColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        data: agreed,
      ),
      new charts.Series<OrdinalStateAdu, String>(
        id: 'disagreed',
        displayName: "Disagreed",
        domainFn: (OrdinalStateAdu adu, _) => adu.age,
        measureFn: (OrdinalStateAdu adu, _) => adu.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.accentColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        data: disagreed,
      ),
      new charts.Series<OrdinalStateAdu, String>(
        id: 'undecided',
        displayName: "Undecided",
        domainFn: (OrdinalStateAdu adu, _) => adu.age,
        measureFn: (OrdinalStateAdu adu, _) => adu.adu,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        data: undecided,
      ),
      // new charts.Series<OrdinalAdu, String>(
      //   id: 'total',
      //   displayName: "total",
      //   domainFn: (OrdinalAdu adu, _) => adu.age,
      //   measureFn: (OrdinalAdu adu, _) => adu.adu,
      //   fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.transparent),
      //   seriesColor: charts.ColorUtil.fromDartColor(Colors.transparent),
      //   data: total,
      // ),
    ];
  }


/// Sample ordinal data type.
class OrdinalStateAdu {
  final String age;
  final double adu;

  OrdinalStateAdu(this.age, this.adu);
}
