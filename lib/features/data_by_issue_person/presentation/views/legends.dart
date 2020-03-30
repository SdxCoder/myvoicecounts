import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LegendWidget extends StatelessWidget {
  final SizingInformation sizingInfo;
  LegendWidget(this.sizingInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 10,
          height: 10,
          child: Container(
            color: themeData.primaryColor,
          ),
        ),
        SizedBox(width: 8),
        Text("Agreed", style: themeData.textTheme.body1.copyWith(
          color: Colors.black54,
          fontSize: (sizingInfo.screenSize.width <= 600) ? sizingInfo.screenSize.width*0.035 :
           sizingInfo.screenSize.height*0.035
        ),
        ),
        SizedBox(width: 8),
         SizedBox(
          width: 10,
          height: 10,
          child: Container(
            color: themeData.accentColor,
          ),
        ),
        SizedBox(width: 8),
        Text("Disagreed", style: themeData.textTheme.body1.copyWith(
          color: Colors.black54,
          fontSize: (sizingInfo.screenSize.width <= 600) ? sizingInfo.screenSize.width*0.035 :
           sizingInfo.screenSize.height*0.035
        ),),
        SizedBox(width: 8),
         SizedBox(
          width: 10,
          height: 10,
          child: Container(
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        Text("Undecided", style: themeData.textTheme.body1.copyWith(
          color: Colors.black54,
          fontSize: (sizingInfo.screenSize.width <= 600) ? sizingInfo.screenSize.width*0.035 :
           sizingInfo.screenSize.height*0.035
        ),),
      ],
    );
  }
}