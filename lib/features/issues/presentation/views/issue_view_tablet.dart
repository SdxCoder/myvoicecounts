import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class IssueViewTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
          body: SizedBox(
            width: sizingInfo.screenSize.width,
            height: sizingInfo.screenSize.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: <Widget>[
                  SizedBox(height: sizingInfo.screenSize.height*0.1),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Bernie Sanders",
                      style: themeData.textTheme.display4.copyWith(
                          color: Colors.grey,
                       ),
                    ),
                  ),
                  
                   SizedBox(height: sizingInfo.screenSize.height*0.1),
                   Divider(height:0),
                  Expanded(child: _buildPoepleList(context, sizingInfo)),
                ],
              ),
            ),
          )),
    );
  }
}

Widget _buildPoepleList(context, sizingInfo) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return _peopleItem(context, index, sizingInfo);
    },
  );
}

Widget _peopleItem(
    BuildContext context, int index, SizingInformation sizingInfo) {
  print(sizingInfo.screenSize);
  return SizedBox(
    height: sizingInfo.screenSize.height*0.3,
    
    child: Row(
      children: <Widget>[
      
        SizedBox(
          height: sizingInfo.screenSize.height*0.2,
          child: Center(
            child: Text("Enviornment",
                style: themeData.textTheme.display4.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Spacer(),
        ButtonBar(
          children: <Widget>[
            InkWell(
                onTap: () {},
                child: Icon(
        FontAwesomeIcons.thumbsUp,
        color: Colors.green,
        size: sizingInfo.screenSize.width*0.04
                )),
            InkWell(
                onTap: () {},
                child: Icon(
        FontAwesomeIcons.thumbsDown,
        color: Colors.red,
        size: sizingInfo.screenSize.width*0.04
                )),
            InkWell(
                onTap: () {},
                child: Icon(
        FontAwesomeIcons.timesCircle,
        color: Colors.grey,
        size: sizingInfo.screenSize.width*0.04
                )),
          ],
        ),
      ],
    ),
  );
}
