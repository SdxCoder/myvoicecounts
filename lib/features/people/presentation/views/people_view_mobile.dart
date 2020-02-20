import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data_by_candidate/data_cadidate.dart';

class PeopleViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
          title: Text('People', style: themeData.textTheme.body1),
          body: SizedBox(
            width: sizingInfo.screenSize.width,
            height: sizingInfo.screenSize.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Would I Vote for You Today?",
                      style: themeData.textTheme.body1.copyWith(
                          color: Colors.grey,
                          fontSize:
                              (sizingInfo.screenSize.height < 600) ? 20 : 26),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(child: _buildPoepleList(context, sizingInfo)),
                  Divider(
                    height: 0,
                    color: themeData.primaryColorDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: sizingInfo.screenSize.width * 0.3,
                          height:
                              (sizingInfo.screenSize.height < 600) ? 40 : 48,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("ISSUES",
                                style: themeData.textTheme.body1
                                    .copyWith(color: Colors.white)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssueView()));
                            },
                            color: themeData.accentColor,
                          ),
                        ),
                        SizedBox(width: sizingInfo.screenSize.width * 0.05),
                        SizedBox(
                          width: sizingInfo.screenSize.width * 0.3,
                          height:
                              (sizingInfo.screenSize.height < 600) ? 40 : 48,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("DATA",
                                style: themeData.textTheme.body1.copyWith(
                                    color: Color(hexColor('f2f2f2')))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder : (context)=> DataCandidateView()));
                            },
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
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
    height: (sizingInfo.screenSize.height < 600 ||
            sizingInfo.screenSize.width < 400)
        ? 130
        : 170,
    child: Row(
      children: <Widget>[
        SizedBox(
          height: (sizingInfo.screenSize.height < 600 ||
                  sizingInfo.screenSize.width < 400)
              ? 80
              : 120,
          child: CircleAvatar(
            minRadius: (sizingInfo.screenSize.height < 600 ||
                    sizingInfo.screenSize.width < 400)
                ? 40
                : 60,
            backgroundImage: AssetImage('images/donald.jpg'),
          ),
        ),
        SizedBox(width: (sizingInfo.screenSize.width < 400) ? 20 : 40),
        SizedBox(
          height: (sizingInfo.screenSize.height < 600 ||
                  sizingInfo.screenSize.width < 400)
              ? 130
              : 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text("Republican Party",
                  style: themeData.textTheme.body1.copyWith(
                    color: Colors.black38,
                    fontSize: (sizingInfo.screenSize.width < 400) ? 14 : 16,
                  )),
              Text("Donald Trump",
                  style: themeData.textTheme.body1.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: (sizingInfo.screenSize.width < 400) ? 20 : 26,
                  )),
              ButtonBar(
                children: <Widget>[
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.green,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  SizedBox(width: 1),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsDown,
                        color: Colors.red,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  SizedBox(width: 1),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: Colors.grey,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
