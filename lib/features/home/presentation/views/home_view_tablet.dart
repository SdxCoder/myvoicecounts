import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/home/presentation/view_models/home_view_model.dart';
import 'package:myvoicecounts/features/home/presentation/widget/map.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:myvoicecounts/features/sfv/sfv.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data/data.dart';

class HomeViewTablet extends StatefulWidget {
  final HomeViewModel model;

  const HomeViewTablet({Key key, this.model}) : super(key: key);

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
      print(sizingInfo.screenSize.width);
      return ScaffoldTablet(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 50),
            SizedBox(
              width: sizingInfo.screenSize.width * 0.17,
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IssueView();
                        }));
                      },
                    ),
                  ),
                  // SizedBox(height: sizingInfo.screenSize.width * 0.03),
                  // SizedBox(
                  //   width: sizingInfo.screenSize.width * 0.2,
                  //   height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                  //   child: RaisedButton(
                  //     color: Colors.green,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(16)),
                  //     elevation: 0,
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     child: Text(
                  //       "DATA",
                  //       style: themeData.textTheme.body1,
                  //     ),
                  //     onPressed: () {
                  //        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataView()));
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: sizingInfo.screenSize.width * 0.03),
                  SizedBox(
                    width: sizingInfo.screenSize.width * 0.2,
                    height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SfvView()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: sizingInfo.screenSize.width * 0.8 - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      // width: sizingInfo.screenSize.width * 0.4
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeData.primaryColor.withOpacity(0.2),
                      ),
                      height: sizingInfo.screenSize.height * 0.7,

                      // Put Map here
                      child: (widget.model.buzy)
                          ? Center(child: Text('Loading...'))
                          : MapView(
                              dataList: widget.model.data,
                            ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    (widget.model.buzy)
                    ? Offstage() : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                           Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                minRadius: sizingInfo.screenSize.width * 0.04,
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
                          SizedBox(width: sizingInfo.screenSize.width * 0.02),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                minRadius: sizingInfo.screenSize.width * 0.04,
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
                          SizedBox(width: sizingInfo.screenSize.width * 0.02),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                minRadius: sizingInfo.screenSize.width * 0.04,
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
                          SizedBox(width: sizingInfo.screenSize.width * 0.02),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                minRadius: sizingInfo.screenSize.width * 0.04,
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
                        Spacer(),
                        (widget.model.buzy)
                            ? Text('')
                            : Text(
                                "Total Votes\n${widget.model.partyData.total}",
                                textAlign: TextAlign.right,
                                style: themeData.textTheme.display3.copyWith(
                                    color: themeData.primaryColorLight),
                              )
                      ],
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
      );
    });
  }
}
