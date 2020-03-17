import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedRaceGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedRaceGraph(this.seriesList, {this.animate, this.sizingInfo});

 GroupedRaceGraph.withRaceData(sizingInfo, seriesList)
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
     
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.

          labelStyle: new charts.TextStyleSpec(
              fontSize: (sizingInfo.screenSize.width <= 600) ? 
              (sizingInfo.screenSize.width*0.02).toInt() :
              (sizingInfo.screenSize.height*0.02).toInt() , // size in Pts.
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
              fontSize: (sizingInfo.screenSize.width <= 600) ? 
              (sizingInfo.screenSize.width*0.02).toInt() :
              (sizingInfo.screenSize.height*0.02).toInt() , // size in Pts.
              color: charts.MaterialPalette.black),
        ),
      ),
    );
  }

  /// Create series list with multiple series
 
}


class OrdinalRaceAdu {
  final String race;
  final int adu;

  OrdinalRaceAdu(this.race, this.adu);
}


  List<charts.Series<OrdinalRaceAdu, String>> createRaceData(DataByIssueViewModel model) {
    final agreed = [
      new OrdinalRaceAdu('American\nIndian', model.data.agree.american),
      new OrdinalRaceAdu('Asian',  model.data.agree.asian),
      new OrdinalRaceAdu('African\nAmerican',  model.data.agree.african),
      new OrdinalRaceAdu('Native\nHawaian',  model.data.agree.hawaian),
      new OrdinalRaceAdu('White',  model.data.agree.white),
    ];

    final disagreed = [
      new OrdinalRaceAdu('American\nIndian',  model.data.disagree.american),
      new OrdinalRaceAdu('Asian', model.data.disagree.asian),
      new OrdinalRaceAdu('African\nAmerican', model.data.disagree.african),
      new OrdinalRaceAdu('Native\nHawaian', model.data.disagree.hawaian),
      new OrdinalRaceAdu('White', model.data.disagree.white),
    ];

    final undecided = [
       new OrdinalRaceAdu('American\nIndian', model.data.undecided.american),
      new OrdinalRaceAdu('Asian',  model.data.undecided.asian),
      new OrdinalRaceAdu('African\nAmerican',  model.data.undecided.african),
      new OrdinalRaceAdu('Native\nHawaian',  model.data.undecided.hawaian),
      new OrdinalRaceAdu('White',  model.data.undecided.white),
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


