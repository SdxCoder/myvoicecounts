import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedEthnicityGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedEthnicityGraph(this.seriesList, {this.animate, this.sizingInfo});

 

  factory GroupedEthnicityGraph.withEthnicityData(sizingInfo) {
    return new GroupedEthnicityGraph(
      _createEthnicityData(),
      // Disable animations for image tests.
      animate: false,
      sizingInfo: sizingInfo,

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
          // Configures the "Other" series to be hidden on first chart draw.
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
  static List<charts.Series<OrdinalEthnicityAdu, String>> _createEthnicityData() {
    final agreed = [
      new OrdinalEthnicityAdu('Hispanic\nLatino', 5),
      new OrdinalEthnicityAdu('Not-Hispanic\nLatino', 25),
     
    ];

    final disagreed = [
     new OrdinalEthnicityAdu('Hispanic\nLatino', 35),
      new OrdinalEthnicityAdu('Not-Hispanic\nLatino', 100),
    ];

    final undecided = [
       new OrdinalEthnicityAdu('Hispanic\nLatino', 25),
      new OrdinalEthnicityAdu('Not-Hispanic\nLatino', 75),
    ];


    return [
      new charts.Series<OrdinalEthnicityAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalEthnicityAdu adu, _) => adu.ethnicity,
        measureFn: (OrdinalEthnicityAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.primaryColor) ,
        data: agreed,
      ),
      new charts.Series<OrdinalEthnicityAdu, String>(
        id: 'disagreed',
         displayName: "Agreed",
        domainFn: (OrdinalEthnicityAdu adu, _) => adu.ethnicity,
        measureFn: (OrdinalEthnicityAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.accentColor) ,
        data: disagreed,
      ),
      new charts.Series<OrdinalEthnicityAdu, String>(
        id: 'undecided',
         displayName: "Agreed",
        domainFn: (OrdinalEthnicityAdu adu, _) => adu.ethnicity,
        measureFn: (OrdinalEthnicityAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(Colors.white) ,
        data: undecided,
      ),
    ];
  }
}

/// Sample ordinal data type.


class OrdinalEthnicityAdu{
  final String ethnicity;
  final int adu;

  OrdinalEthnicityAdu(this.ethnicity, this.adu);

}