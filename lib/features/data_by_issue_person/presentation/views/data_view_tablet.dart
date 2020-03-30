import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data_by_issue_person/data/person_issue_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/presentation/view_models/dataByPerson_Issue_view_model.dart';
import 'package:myvoicecounts/features/data_by_issue_person/presentation/widgets/date_picker.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';

import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/grouped_age_graphs.dart';

import '../widgets/widgets.dart';
import 'legends.dart';

class DataViewTablet extends StatelessWidget {
  final DataByPersonIssueViewModel model;
  final PersonIssueObject personIssueObject;

  const DataViewTablet({Key key, this.model, this.personIssueObject})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: sizingInfo.screenSize.height * 0.2,
                  bottom: sizingInfo.screenSize.height * 0.1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: (model.buzy)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(themeData.primaryColor),
                        ),
                      )
                    : (model.noData == true)
                        ? Center(
                            child: Text("No Data"),
                          )
                        : GridView.count(
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing:
                                sizingInfo.screenSize.height * 0.05,
                            crossAxisSpacing:
                                sizingInfo.screenSize.height * 0.02,
                            children: <Widget>[
                              _buildGraphByTopAge(context, sizingInfo),
                              _buildGraphByGender(context, sizingInfo),
                              _buildGraphByEthnicity(context, sizingInfo),
                              _buildGraphByRace(context, sizingInfo),
                              _buildGraphByParty(context, sizingInfo),
                              _buildGraphByState(context, sizingInfo)
                            ],
                          ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 32, right:32),
                child:   Container(
               
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: (sizingInfo.screenSize.height < 600 ||
                                  sizingInfo.screenSize.width < 400)
                              ? 40
                              : 120,
                          child: (personIssueObject.candidate.imageUrl == null ||
                                  personIssueObject.candidate.imageUrl.isEmpty)
                              ? CircleAvatar(
                                  minRadius:
                                      (sizingInfo.screenSize.height < 600 ||
                                              sizingInfo.screenSize.width < 400)
                                          ? 20
                                          : 60,
                                  backgroundColor:
                                      themeData.primaryColor.withOpacity(0.4),
                                  child: Icon(Icons.person,
                                      size: 50, color: themeData.primaryColor),
                                )
                              : CircleAvatar(
                                  minRadius:
                                      (sizingInfo.screenSize.height < 600 ||
                                              sizingInfo.screenSize.width < 400)
                                          ? 20
                                          : 60,
                                  backgroundImage:
                                      NetworkImage(personIssueObject.candidate.imageUrl),
                                ),
                        ),
                        SizedBox(
                            width: (sizingInfo.screenSize.width < 400) ? 20 : 40),
                        SizedBox(
                          width: sizingInfo.screenSize.width - 400,
                          height: (sizingInfo.screenSize.height < 600 ||
                                  sizingInfo.screenSize.width < 400)
                              ? 100
                              : 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(personIssueObject.candidate.party,
                                  style: themeData.textTheme.body1.copyWith(
                                    color: Colors.black38,
                                    fontSize: (sizingInfo.screenSize.width < 400)
                                        ? 14
                                        : 26,
                                  )),
                              Text(personIssueObject.candidate.name,
                                  style: themeData.textTheme.body1.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: (sizingInfo.screenSize.width < 400)
                                        ? 16
                                        : 32,
                                  )),
                               Container(
                                 width: sizingInfo.screenSize.width - 100,
                                 child: Text(personIssueObject.issue.issueName,
                                    style: themeData.textTheme.body1.copyWith(
                                      color: Colors.black54,
                                  
                                      fontSize: (sizingInfo.screenSize.width < 400)
                                          ? 16
                                          : 26,
                                    )),
                               ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
               ),
              ),
            ),
            Positioned(
              top: sizingInfo.screenSize.height * 0.1,
              right: 32,
              child: FloatingActionButton(
                  backgroundColor: themeData.primaryColor,
                  foregroundColor: Colors.white,
                  tooltip: "Select Date",
                  onPressed: () async {
                    await showCalenderDialogBox(
                        title: "Select Date",
                        content: DateRangePicker(
                          onNewRangeSelected: (period) {
                            model.fetchPeriod(period);
                            model.fetchData(
                              period,
                              personIssueObject.issue.documentId,
                                personIssueObject.candidate.documentId
                            );
                          },
                        ));

                    print(
                        "${model.selectedPeriod.start} - ${model.selectedPeriod.start}");
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
                        width: sizingInfo.screenSize.width * 0.2,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("ISSUES",
                              style: themeData.textTheme.display2
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
                        width: sizingInfo.screenSize.width * 0.2,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("PEOPLE",
                              style: themeData.textTheme.display2
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

  Widget _buildGraphByTopAge(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('TOP 5 AGE GROUPS',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
                //  fontWeight: FontWeight.light,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedTopAgeGraph.withTopAgeData(
                sizingInfo, createTopAgeData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }

  Widget _buildGraphByGender(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('GENDER',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
                // fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedGenderGraph.withGenderData(
                sizingInfo, createGenderData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }

  Widget _buildGraphByEthnicity(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('ETHNICITY',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
                //   fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedEthnicityGraph.withEthnicityData(
                sizingInfo, createEthnicityData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }

  Widget _buildGraphByParty(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('PARTY',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
                //  fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedPartyGraph.withPartyData(
                sizingInfo, createPartyData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }

  Widget _buildGraphByRace(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('RACE',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
                //   fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedRaceGraph.withRaceData(
                sizingInfo, createRaceData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }

  Widget _buildGraphByState(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('TOP STATES',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.height * 0.04,
              //  fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedTopStateGraph.withTopStateData(
                sizingInfo, createTopStateData(model)),
          ),
          SizedBox(
            height: sizingInfo.screenSize.height * 0.03,
          ),
          LegendWidget(sizingInfo)
        ],
      ),
    );
  }
}
