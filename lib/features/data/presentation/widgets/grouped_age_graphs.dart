import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedTopAgeGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedTopAgeGraph(this.seriesList, {this.animate, this.sizingInfo});

  factory GroupedTopAgeGraph.withTopAgeData(sizingInfo) {
    return new GroupedTopAgeGraph(
      _createTopAgeData(),
      // Disable animations for image tests.
      sizingInfo: sizingInfo,
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
      

        new charts.SeriesLegend(
         
          defaultHiddenSeries: ['Other'],
          position: charts.BehaviorPosition.bottom,
          cellPadding: EdgeInsets.only(
            top : sizingInfo.screenSize.height*0.03, 
            left: 16),
         
          outsideJustification: charts.OutsideJustification.middle,
          entryTextStyle: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(themeData.primaryColorDark),
              fontFamily: 'Georgia',
              fontSize: 11),
        )
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.

          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width*0.04).toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),

      

    

       domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelOffsetFromAxisPx: 16,
          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width*0.04).toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
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
}

/// Sample ordinal data type.
class OrdinalAdu {
  final String age;
  final int adu;

  OrdinalAdu(this.age, this.adu);
}
