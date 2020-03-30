import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedTopAgeGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedTopAgeGraph(this.seriesList,
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

  GroupedTopAgeGraph.withTopAgeData(sizingInfo, seriesList)
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
      behaviors: [],
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

 List<charts.Series<OrdinalAdu, String>> createTopAgeData(DataByIssueViewModel model) {
    final agreed = [
      new OrdinalAdu('15-20', model.data.agree.groupA),
      new OrdinalAdu('21-35', model.data.agree.groupB),
      new OrdinalAdu('36-50', model.data.agree.groupC),
      new OrdinalAdu('51-65', model.data.agree.groupD),
       new OrdinalAdu('66-Older', model.data.agree.groupE),
    ];

    final disagreed = [
      new OrdinalAdu('15-20', model.data.disagree.groupA),
      new OrdinalAdu('21-35',  model.data.disagree.groupB),
      new OrdinalAdu('36-50',  model.data.disagree.groupC),
      new OrdinalAdu('51-65',  model.data.disagree.groupD),
      new OrdinalAdu('66-Older', model.data.disagree.groupE),
    ];

    final undecided = [
      new OrdinalAdu('15-20',  model.data.undecided.groupA),
      new OrdinalAdu('21-35', model.data.undecided.groupB),
      new OrdinalAdu('36-50', model.data.undecided.groupC),
      new OrdinalAdu('51-65', model.data.undecided.groupD),
      new OrdinalAdu('66-Older', model.data.undecided.groupE),
    ];

    return [
      new charts.Series<OrdinalAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalAdu adu, _) => adu.age,
        measureFn: (OrdinalAdu adu, _) => adu.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.primaryColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        data: agreed,
      ),
      new charts.Series<OrdinalAdu, String>(
        id: 'disagreed',
        displayName: "Disagreed",
        domainFn: (OrdinalAdu adu, _) => adu.age,
        measureFn: (OrdinalAdu adu, _) => adu.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.accentColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        data: disagreed,
      ),
      new charts.Series<OrdinalAdu, String>(
        id: 'undecided',
        displayName: "Undecided",
        domainFn: (OrdinalAdu adu, _) => adu.age,
        measureFn: (OrdinalAdu adu, _) => adu.adu,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        data: undecided,
      ),
    ];
  }


/// Sample ordinal data type.
class OrdinalAdu {
  final String age;
  final double adu;

  OrdinalAdu(this.age, this.adu);
}
