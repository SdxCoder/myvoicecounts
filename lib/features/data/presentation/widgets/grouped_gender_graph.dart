import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedGenderGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedGenderGraph(this.seriesList, {this.animate, this.sizingInfo});

 

  factory GroupedGenderGraph.withGenderData(sizingInfo) {
    return new GroupedGenderGraph(
      _createGenderData(),
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
  static List<charts.Series<OrdinalAgeAdu, String>> _createGenderData() {
    final agreed = [
      new OrdinalAgeAdu('Males', 5),
      new OrdinalAgeAdu('Females', 25),
     
    ];

    final disagreed = [
     new OrdinalAgeAdu('Males', 35),
      new OrdinalAgeAdu('Females', 100),
    ];

    final undecided = [
       new OrdinalAgeAdu('Males', 25),
      new OrdinalAgeAdu('Females', 75),
    ];


    return [
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'agreed',
        displayName: "Agreed",
        domainFn: (OrdinalAgeAdu adu, _) => adu.gender,
        measureFn: (OrdinalAgeAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(themeData.primaryColor),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.primaryColor) ,
        data: agreed,
      ),
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'disagreed',
         displayName: "Agreed",
        domainFn: (OrdinalAgeAdu adu, _) => adu.gender,
        measureFn: (OrdinalAgeAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.accentColor) ,
        data: disagreed,
      ),
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'undecided',
         displayName: "Agreed",
        domainFn: (OrdinalAgeAdu adu, _) => adu.gender,
        measureFn: (OrdinalAgeAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
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