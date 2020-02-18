/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PieChartGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final SizingInformation sizingInfo;

  PieChartGraph(this.seriesList, {this.animate, this.sizingInfo});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieChartGraph.withCandidateData(sizingInfo) {
    return new PieChartGraph(
      _createCandidateData(),
      // Disable animations for image tests.
      animate: false,
      sizingInfo: sizingInfo,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createCandidateData() {
    final data = [
      new LinearSales("Agreed", 100),
      new LinearSales("Disagreed", 75),
      new LinearSales("Undecided", 25),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      //  colorFn:(_,__ ) =>  charts.MaterialPalette.purple.shadeDefault,
        fillColorFn:(_,__ ) =>  charts.MaterialPalette.purple.shadeDefault.lighter,
        insideLabelStyleAccessorFn: (_,__) => charts.TextStyleSpec(
          fontSize: 16,
          color: charts.ColorUtil.fromDartColor(Colors.white)

        ),
       
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year} - ${row.sales}%',
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String year;
  final int sales;

  LinearSales(this.year, this.sales);
}