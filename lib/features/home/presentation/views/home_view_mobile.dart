import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/home/presentation/view_models/home_view_model.dart';
import 'package:myvoicecounts/features/home/presentation/widget/map.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:myvoicecounts/features/sfv/sfv.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeViewMobile extends StatefulWidget {
  final HomeViewModel model;

  const HomeViewMobile({Key key, this.model}) : super(key: key);
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
                    decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                       color: themeData.primaryColor.withOpacity(0.2),
                    ),
                   // color: Colors.red,
                    margin: EdgeInsets.only(top:(sizingInfo.screenSize.height < 570) ? 8 : 16, left: 8, right: 8),
                    height: sizingInfo.screenSize.height * 0.45,
                    child: (widget.model.buzy)
                        ? Center(child: Text('Loading...'))
                        : MapView(
                            dataList: widget.model.data,
                          ),
                  ),
                  Positioned(
                      top: 24,
                      right: 20,
                      child: (widget.model.buzy)
                          ? Text('')
                          : Text(
                              "Total Votes\n${widget.model.partyData.total}",
                              textAlign: TextAlign.right,
                              style: themeData.textTheme.body1
                                  .copyWith(color: themeData.primaryColorLight),
                            ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8.0, left: 16, right: 16),
                child: (widget.model.buzy)
                    ? Offstage()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                minRadius: sizingInfo.screenSize.width * 0.07,
                                child: (widget.model.buzy)
                                    ? Text('')
                                    : Text(
                                        "${widget.model.partyData.independent}%",
                                        style: themeData.textTheme.body1,
                                      ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Indep")
                            ],
                          ),
                          SizedBox(width: sizingInfo.screenSize.width * 0.03),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                minRadius: sizingInfo.screenSize.width * 0.07,
                                child: Text(
                                  "${widget.model.partyData.democrat}%",
                                  style: themeData.textTheme.body1
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Dem")
                            ],
                          ),
                          SizedBox(width: sizingInfo.screenSize.width * 0.03),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                minRadius: sizingInfo.screenSize.width * 0.07,
                                child: Text(
                                  "${widget.model.partyData.republic}%",
                                  style: themeData.textTheme.body1
                                      .copyWith(color: Colors.black54),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Rep")
                            ],
                          ),
                          SizedBox(width: sizingInfo.screenSize.width * 0.03),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                minRadius: sizingInfo.screenSize.width * 0.07,
                                child: Text(
                                  "${widget.model.partyData.other}%",
                                  style: themeData.textTheme.body1
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Other")
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(height: sizingInfo.screenSize.width * 0.02),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: sizingInfo.screenSize.width * 0.4,
                    height: (sizingInfo.screenSize.width < 600) ? 40 : 70,
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
                    height: (sizingInfo.screenSize.width < 600) ? 40 : 70,
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
                    height: (sizingInfo.screenSize.width < 600) ? 40 : 70,
                    child: RaisedButton(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  SizedBox(height: 8)
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
