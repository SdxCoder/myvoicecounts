import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/home/presentation/widget/map.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:myvoicecounts/features/sfv/sfv.dart';
import 'package:responsive_builder/responsive_builder.dart';



import '../../../data/data.dart';


class HomeViewMobile extends StatefulWidget {
  @override
  _HomeViewMobileState createState() => _HomeViewMobileState();
}

class _HomeViewMobileState extends State<HomeViewMobile> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      print(sizingInfo.screenSize);
      return ScaffoldMobile(
        title: Text("Home", style: themeData.textTheme.body1),
        body: Container(
         // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    // Put Map here
               
                    height: sizingInfo.screenSize.height * 0.3,
                   // child: MapView(),

                  ),
                  Positioned(
                      top: 0,
                      right: 16,
                      child: Text(
                        "Total Votes\n45,67,800",
                        textAlign: TextAlign.right,
                        style: themeData.textTheme.body1
                            .copyWith(color: themeData.primaryColorLight),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      minRadius: sizingInfo.screenSize.width * 0.07,
                      child: Text(
                        "48%",
                        style: themeData.textTheme.body1,
                      ),
                    ),
                    SizedBox(width: sizingInfo.screenSize.width * 0.03),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      minRadius: sizingInfo.screenSize.width * 0.07,
                      child: Text(
                        "22%",
                        style: themeData.textTheme.body1,
                      ),
                    ),
                    SizedBox(width: sizingInfo.screenSize.width * 0.03),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: sizingInfo.screenSize.width * 0.07,
                      child: Text(
                        "25%",
                        style: themeData.textTheme.body1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: sizingInfo.screenSize.width * 0.03),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      minRadius: sizingInfo.screenSize.width * 0.07,
                      child: Text(
                        "25%",
                        style: themeData.textTheme.body1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizingInfo.screenSize.width * 0.03),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: sizingInfo.screenSize.width * 0.4,
                    height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                    child: RaisedButton(
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "PEOPLE",
                        style: themeData.textTheme.body1
                            .copyWith(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PeopleView();
                        }));
                      },
                    ),
                  ),
                  SizedBox(height: sizingInfo.screenSize.width * 0.03),
                  SizedBox(
                    width: sizingInfo.screenSize.width * 0.4,
                    height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                    child: RaisedButton(
                      color: themeData.accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "ISSUES",
                        style: themeData.textTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IssueView();
                        }));
                      },
                    ),
                  ),
                  SizedBox(height: sizingInfo.screenSize.width * 0.03),
                  // SizedBox(
                  //   width: sizingInfo.screenSize.width * 0.4,
                  //   height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                  //   child: RaisedButton(
                  //     color: Colors.green,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(16)),
                  //     elevation: 0,
                  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     child: Text(
                  //       "DATA",
                  //       style: themeData.textTheme.body1,
                  //     ),
                  //     onPressed: () {
                  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataView()));
                  //     },
                  //   ),
                  // ),
                  //  SizedBox(height: sizingInfo.screenSize.width * 0.03),
                  SizedBox(
                    width: sizingInfo.screenSize.width * 0.4,
                    height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                    child: RaisedButton(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "VIDEOS",
                        style: themeData.textTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SfvView();
                        }));
                      },
                    ),
                  ),
                  SizedBox(height: 16)
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
