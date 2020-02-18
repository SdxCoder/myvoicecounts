import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedRaceGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedRaceGraph(this.seriesList, {this.animate, this.sizingInfo});

  factory GroupedRaceGraph.withRaceData(sizingInfo) {
    return new GroupedRaceGraph(
      _createRaceData(),
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
          lineStyle: charts.LineStyleSpec(
            thickness: 0,
            color: charts.ColorUtil.fromDartColor(Colors.white)
          ),
          labelOffsetFromAxisPx: 16,
          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width*0.03).toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalRaceAdu, String>> _createRaceData() {
    final agreed = [
      new OrdinalRaceAdu('American\nIndian', 5),
      new OrdinalRaceAdu('Asian', 25),
      new OrdinalRaceAdu('African\nAmerican', 100),
      new OrdinalRaceAdu('Native\nHawaian', 67),
      new OrdinalRaceAdu('White', 75),
    ];

    final disagreed = [
      new OrdinalRaceAdu('American\nIndian', 5),
      new OrdinalRaceAdu('Asian', 25),
      new OrdinalRaceAdu('African\nAmerican', 100),
      new OrdinalRaceAdu('Native\nHawaian', 67),
      new OrdinalRaceAdu('White', 75),
    ];

    final undecided = [
       new OrdinalRaceAdu('American\nIndian', 5),
      new OrdinalRaceAdu('Asian', 25),
      new OrdinalRaceAdu('African\nAmerican', 100),
      new OrdinalRaceAdu('Native\nHawaian', 67),
      new OrdinalRaceAdu('White', 75),
    ];

    return [
      new charts.Series<OrdinalRaceAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalRaceAdu adu, _) =>adu.race,
        measureFn: (OrdinalRaceAdu adu, _) =>adu.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.primaryColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        data: agreed,
      ),
      new charts.Series<OrdinalRaceAdu, String>(
        id: 'disagreed',
        displayName: "Disagreed",
        domainFn: (OrdinalRaceAdu adu, _) =>adu.race,
        measureFn: (OrdinalRaceAdu adu, _) =>adu.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.accentColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        data: disagreed,
      ),
      new charts.Series<OrdinalRaceAdu, String>(
        id: 'undecided',
        displayName: "Undecided",
        domainFn: (OrdinalRaceAdu adu, _) =>adu.race,
        measureFn: (OrdinalRaceAdu adu, _) =>adu.adu,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        data: undecided,
      ),
    ];
  }

}


class OrdinalRaceAdu {
  final String race;
  final int adu;

  OrdinalRaceAdu(this.race, this.adu);
}

