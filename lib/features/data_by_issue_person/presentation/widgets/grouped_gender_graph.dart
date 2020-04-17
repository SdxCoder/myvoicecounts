import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/presentation/view_models/dataByPerson_Issue_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GroupedGenderGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  GroupedGenderGraph(this.seriesList, {this.animate, this.sizingInfo});

 

  GroupedGenderGraph.withGenderData(sizingInfo, seriesList)
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
}
    ///
/// Sample ordinal data type.


class OrdinalAgeAdu{
  final String gender;
  final double adu;

  OrdinalAgeAdu(this.gender, this.adu);

}


  List<charts.Series<OrdinalAgeAdu, String>> createGenderData(DataByPersonIssueViewModel model) {
    final agreed = [
      new OrdinalAgeAdu('Male',  model.data.agree.male),
      new OrdinalAgeAdu('Female', model.data.agree.female),
     
    ];

    final disagreed = [
     new OrdinalAgeAdu('Male', model.data.disagree.male),
      new OrdinalAgeAdu('Female', model.data.disagree.female),
    ];

    final undecided = [
       new OrdinalAgeAdu('Male', model.data.undecided.male),
      new OrdinalAgeAdu('Female', model.data.undecided.female),
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
         displayName: "Disagreed",
        domainFn: (OrdinalAgeAdu adu, _) => adu.gender,
        measureFn: (OrdinalAgeAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(themeData.accentColor),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(themeData.accentColor) ,
        data: disagreed,
      ),
      new charts.Series<OrdinalAgeAdu, String>(
        id: 'undecided',
         displayName: "Undecided",
        domainFn: (OrdinalAgeAdu adu, _) => adu.gender,
        measureFn: (OrdinalAgeAdu adu, _) => adu.adu,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        fillColorFn:(_,__ ) => charts.ColorUtil.fromDartColor(Colors.white) ,
        data: undecided,
      ),
    ];
  }
