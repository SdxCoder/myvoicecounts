import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/widgets/widgets.dart';

import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/data/presentation/views/legends.dart';
import 'package:myvoicecounts/features/data/presentation/widgets/date_picker.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/grouped_age_graphs.dart';

import '../widgets/widgets.dart';

class DataViewMobile extends StatelessWidget {
  final DataByIssueViewModel model;
  final Issue issue;

  const DataViewMobile({Key key, this.model, this.issue}) : super(key: key);
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
              margin: EdgeInsets.only(
                  top: sizingInfo.screenSize.width * 0.2,
                  bottom: sizingInfo.screenSize.width * 0.2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: 
                (model.buzy) ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(themeData.primaryColor),
                ),):
                (model.noData == true)
                    ? Center(
                        child: Text("No Data"),
                      )
                    : GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 1,
                        mainAxisSpacing: sizingInfo.screenSize.height * 0.05,
                        children: <Widget>[
                          _buildGraphByTopAge(context, sizingInfo),
                          _buildGraphByGender(context, sizingInfo,),
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
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 16,
                  left: 16
                ),
                child: Text(
                  issue.issueName,
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.grey, fontSize: headlineSize(sizingInfo)),
                ),
              ),
            ),
            Positioned(
              top: sizingInfo.screenSize.width * 0.17,
              right: 16,
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
                           model.fetchData(period, issue.documentId);
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

  Widget _buildGraphByTopAge(context, SizingInformation sizingInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('TOP 5 AGE GROUPS',
              style: themeData.textTheme.body1.copyWith(
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
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
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedGenderGraph.withGenderData(sizingInfo, createGenderData(model)),
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
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedEthnicityGraph.withEthnicityData( sizingInfo,createEthnicityData(model) ),
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
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedPartyGraph.withPartyData(sizingInfo, createPartyData(model)),
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
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedRaceGraph.withRaceData(sizingInfo, createRaceData(model)),
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
                fontSize: sizingInfo.screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedTopStateGraph.withTopStateData(sizingInfo, createTopStateData(model)),
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
