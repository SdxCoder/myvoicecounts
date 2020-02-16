import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeViewTablet extends StatefulWidget {
  @override
  _HomeViewTabletState createState() => _HomeViewTabletState();
}

class _HomeViewTabletState extends State<HomeViewTablet> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Stack(
        children: <Widget>[
          Container(
              width: 70,
              decoration: BoxDecoration(
                color:themeData.primaryColorLight
              ),
            ),

           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {}),
                 Spacer(),
                 IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {}),
            ]),
          ),

          Container(
            margin: EdgeInsets.only(left:70),
            decoration: BoxDecoration(
              gradient: gradientHome,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 50),
                SizedBox(
                  width: sizingInfo.screenSize.width * 0.2 - 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.2,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                        child: RaisedButton(
                          color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "PEOPLE",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return PeopleView();
                            }));
                          },
                        ),
                      ),
                      SizedBox(height: sizingInfo.screenSize.width * 0.03),
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.2,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                        child: RaisedButton(
                          color: themeData.accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "ISSUES",
                            style: themeData.textTheme.body1,
                          ),
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return IssueView();
                            }));
                          },
                        ),
                      ),
                      SizedBox(height: sizingInfo.screenSize.width * 0.03),
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.2,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                        child: RaisedButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "DATA",
                            style: themeData.textTheme.body1,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16),
                  child: SizedBox(
                    width: sizingInfo.screenSize.width * 0.8 - 116,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // width: sizingInfo.screenSize.width * 0.4,
                          height: sizingInfo.screenSize.height * 0.7,
                          // Put Map here

                        ),
                        SizedBox(height: 16,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              minRadius: sizingInfo.screenSize.width * 0.04,
                              child: Text(
                                "48%",
                                style: themeData.textTheme.display2,
                              ),
                            ),
                            SizedBox(width: sizingInfo.screenSize.width * 0.03),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              minRadius: sizingInfo.screenSize.width * 0.04,
                              child: Text(
                                "22%",
                                style: themeData.textTheme.display2,
                              ),
                            ),
                            SizedBox(width: sizingInfo.screenSize.width * 0.03),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              minRadius: sizingInfo.screenSize.width * 0.04,
                              child: Text(
                                "25%",
                                style: themeData.textTheme.display2
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: sizingInfo.screenSize.width * 0.03),
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              minRadius: sizingInfo.screenSize.width * 0.04,
                              child: Text(
                                "25%",
                                style: themeData.textTheme.display2
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Spacer(),
                            Text(
                                  "Total Votes\n4567800",
                                  textAlign: TextAlign.right,
                                  style: themeData.textTheme.display3
                                      .copyWith(color: themeData.primaryColorLight),
                                )
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
