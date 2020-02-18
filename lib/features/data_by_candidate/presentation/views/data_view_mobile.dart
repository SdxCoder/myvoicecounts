import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/widgets.dart';

class DataViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
        title: Text(
          "Demographics By Issue",
          style: themeData.textTheme.body1,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: sizingInfo.screenSize.width*0.2,
              bottom: sizingInfo.screenSize.width*0.2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 1,
                  mainAxisSpacing: sizingInfo.screenSize.height * 0.05,
                  children: <Widget>[
                    _buildGraphForCandidate(context, sizingInfo),
                   
                    
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left:16.0,),
                child: Text(
                  "How am I doing?",
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.grey,
                      fontSize:sizingInfo.screenSize.width*0.06),
                ),
              ),
            ),
            Positioned(
              top: sizingInfo.screenSize.width*0.17,
              right: 16,
              child: FloatingActionButton(
                  backgroundColor: themeData.primaryColor,
                  foregroundColor: Colors.white,
                  tooltip: "Select Date",
                  onPressed: () {},
                  child: Icon(
                    FontAwesomeIcons.calendarAlt,
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(hexColor('c096ca')),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.3,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("ISSUES",
                              style: themeData.textTheme.body1
                                  .copyWith(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => IssueView()));
                          },
                          color: themeData.accentColor,
                        ),
                      ),
                      SizedBox(width: sizingInfo.screenSize.width * 0.05),
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.3,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("PEOPLE",
                              style: themeData.textTheme.body1
                                  .copyWith(color: Color(hexColor('f2f2f2')))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PeopleView()));
                          },
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphForCandidate(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('Sentiment on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: PieChartGraph.withCandidateData(sizingInfo),
          )
        ],
      ),
    );
  }

}
