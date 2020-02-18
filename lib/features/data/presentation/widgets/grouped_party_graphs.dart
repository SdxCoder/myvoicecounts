import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedPartyGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedPartyGraph(this.seriesList, {this.animate, this.sizingInfo});

  factory GroupedPartyGraph.withPartyData(sizingInfo) {
    return new GroupedPartyGraph(
      _createPartyData(),
      // Disable animations for image tests.
      sizingInfo: sizingInfo,
      animate: true,
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
              fontSize: (sizingInfo.screenSize.width*0.03).toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalPartyAdu, String>> _createPartyData() {
    final agreed = [
      new OrdinalPartyAdu('Democrat', 5),
      new OrdinalPartyAdu('Independent', 25),
      new OrdinalPartyAdu('Republican', 100),
      new OrdinalPartyAdu('Other', 75),
    ];

    final disagreed = [
      new OrdinalPartyAdu('Democrat', 5),
      new OrdinalPartyAdu('Independent', 25),
      new OrdinalPartyAdu('Republican', 100),
      new OrdinalPartyAdu('Other', 75),
    ];

    final undecided = [
      new OrdinalPartyAdu('Democrat', 5),
      new OrdinalPartyAdu('Independent', 25),
      new OrdinalPartyAdu('Republican', 100),
      new OrdinalPartyAdu('Other', 75),
    ];

    return [
      new charts.Series<OrdinalPartyAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalPartyAdu sales, _) => sales.party,
        measureFn: (OrdinalPartyAdu sales, _) => sales.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.primaryColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        data: agreed,
      ),
      new charts.Series<OrdinalPartyAdu, String>(
        id: 'disagreed',
        displayName: "Disagreed",
        domainFn: (OrdinalPartyAdu sales, _) => sales.party,
        measureFn: (OrdinalPartyAdu sales, _) => sales.adu,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(themeData.accentColor),
        seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        data: disagreed,
      ),
      new charts.Series<OrdinalPartyAdu, String>(
        id: 'undecided',
        displayName: "Undecided",
        domainFn: (OrdinalPartyAdu sales, _) => sales.party,
        measureFn: (OrdinalPartyAdu sales, _) => sales.adu,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        data: undecided,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalPartyAdu {
  final String party;
  final int adu;

  OrdinalPartyAdu(this.party, this.adu);
}
