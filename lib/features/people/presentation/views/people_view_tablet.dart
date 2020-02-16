import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PeopleViewTablet extends StatelessWidget {
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
                      "Would I Vote for You Today?",
                      style: themeData.textTheme.display4.copyWith(
                          color: Colors.grey,
                       ),
                    ),
                  ),
                   SizedBox(height: sizingInfo.screenSize.height*0.1),
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
          child: CircleAvatar(
            minRadius: sizingInfo.screenSize.height*0.1,
            backgroundImage: AssetImage('images/donald.jpg'),
          ),
        ),
        SizedBox(width: sizingInfo.screenSize.height*0.1),
        SizedBox(
          height: sizingInfo.screenSize.height*0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
              Text("Republican Party",
                  style: themeData.textTheme.display3.copyWith(
                    color: Colors.black38,
                   
                  )),
              
              Text("Donald Trump",
                  style: themeData.textTheme.display4.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  )),
            ],
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
