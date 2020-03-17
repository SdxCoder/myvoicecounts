import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/widgets/date_picker.dart';
import 'package:myvoicecounts/features/data_by_candidate/presentation/view_models/data_person_view_model.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/widgets.dart';

class DataViewTablet extends StatelessWidget {
  final DataByPersonViewModel model;
  final Candidate candidate;

  const DataViewTablet({Key key, this.model, this.candidate}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: sizingInfo.screenSize.height*0.15,
              bottom: sizingInfo.screenSize.width*0.2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: (model.buzy) ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(themeData.primaryColor),
                ),):
                (model.noData == true)
                    ? Center(
                        child: Text("No Data"),
                      )
                    :  
                     Center(child: _buildGraphForCandidate(context, sizingInfo)),
                // GridView.count(
                //   physics: BouncingScrollPhysics(),
                //   crossAxisCount: 1,
                //   mainAxisSpacing: sizingInfo.screenSize.height * 0.25,
                //   crossAxisSpacing: sizingInfo.screenSize.height * 0.25,
                //   children: <Widget>[
                //     _buildGraphForCandidate(context, sizingInfo),
                    
                //   ],
                // ),
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
                      fontSize:headlineSize(sizingInfo),)
                ),
              ),
            ),
            Positioned(
              top: sizingInfo.screenSize.height*0.1,
              right: 32,
              width: 48,
              height: 48,
              child: FloatingActionButton(

                  backgroundColor: themeData.primaryColor,
                  foregroundColor: Colors.white,
                  tooltip: "Select Date",
                   onPressed: () async {
                    await showCalenderDialogBox(
                      title: "Select Date",
                      content: DateRangePicker(
                        onNewRangeSelected: (period){
                          model.fetchPeriod(period);
                           model.fetchData(period, candidate.documentId);
                        },
                      )
                    );
                   
                    
                    print("${model.selectedPeriod.start} - ${model.selectedPeriod.start}");
                  },
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Sentiment on ${model.selectedPeriod.start.getDate()} to ${model.selectedPeriod.end.getDate()}',
                style: themeData.textTheme.body1.copyWith(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
            SizedBox(
              height: sizingInfo.screenSize.width * 0.05,
            ),
            Expanded(
              child: PieChartGraph.withCandidateData(sizingInfo, createCandidateData(model)),
            )
          ],
        ),
      ),
    );
  }


}
