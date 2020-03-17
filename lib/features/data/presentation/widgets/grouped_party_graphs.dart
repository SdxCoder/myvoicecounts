import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedPartyGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedPartyGraph(this.seriesList, {this.animate, this.sizingInfo});

 GroupedPartyGraph.withPartyData(sizingInfo, seriesList)
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

/// Sample ordinal data type.
class OrdinalPartyAdu {
  final String party;
  final int adu;

  OrdinalPartyAdu(this.party, this.adu);
}



List<charts.Series<OrdinalPartyAdu, String>> createPartyData(DataByIssueViewModel model) {
    final agreed = [
      new OrdinalPartyAdu('Democrat', model.data.agree.democrat),
      new OrdinalPartyAdu('Independent', model.data.agree.independent),
      new OrdinalPartyAdu('Republican', model.data.agree.republic),
      new OrdinalPartyAdu('Other', model.data.agree.other),
    ];

    final disagreed = [
      new OrdinalPartyAdu('Democrat', model.data.disagree.democrat),
      new OrdinalPartyAdu('Independent', model.data.disagree.independent),
      new OrdinalPartyAdu('Republican', model.data.disagree.republic),
      new OrdinalPartyAdu('Other', model.data.disagree.other),
    ];

    final undecided = [
      new OrdinalPartyAdu('Democrat', model.data.undecided.democrat),
      new OrdinalPartyAdu('Independent', model.data.undecided.independent),
      new OrdinalPartyAdu('Republican', model.data.undecided.republic),
      new OrdinalPartyAdu('Other', model.data.undecided.other),
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