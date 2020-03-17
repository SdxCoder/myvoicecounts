import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/data/presentation/view_models/dataByIssue_view_model.dart';
import 'package:myvoicecounts/features/data/presentation/views/legends.dart';
import 'package:myvoicecounts/features/data/presentation/widgets/date_picker.dart';
import 'package:myvoicecounts/features/data/presentation/widgets/grouped_gender_graph.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/grouped_age_graphs.dart';

import '../widgets/widgets.dart';

class DataViewTablet extends StatelessWidget {
  final DataByIssueViewModel model;
  final Issue issue;

  const DataViewTablet({Key key, this.model, this.issue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: sizingInfo.screenSize.height*0.1,
              bottom: sizingInfo.screenSize.height*0.1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child:
                 (model.buzy) ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(themeData.primaryColor),
                ),):
                (model.noData == true)
                    ? Center(
                        child: Text("No Data"),
                      )
                    :
                 GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: sizingInfo.screenSize.height * 0.05,
                  crossAxisSpacing: sizingInfo.screenSize.height * 0.02,
                  children: <Widget>[
                    _buildGraphByTopAge(context, sizingInfo),
                    _buildGraphByGender(context, sizingInfo),
                    _buildGraphByEthnicity(context, sizingInfo),
                    _buildGraphByRace(context, sizingInfo),
                    _buildGraphByParty(context, sizingInfo)
                    
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Regulate Fracking?",
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.grey,
                      fontSize:sizingInfo.screenSize.height*0.06),
                ),
              ),
            ),
            Positioned(
              top: sizingInfo.screenSize.height*0.1,
              right: 32,
              child: FloatingActionButton(
                  backgroundColor: themeData.primaryColor,
                  foregroundColor: Colors.white,
                  tooltip: "Select Date",
                  onPressed: () async{
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
                        width: sizingInfo.screenSize.height * 0.2,
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
            child: GroupedTopAgeGraph.withTopAgeData(sizingInfo, createTopAgeData(model)),
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
                fontSize: sizingInfo.screenSize.height * 0.04,
             //   fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
          SizedBox(
            height: sizingInfo.screenSize.width * 0.05,
          ),
          Expanded(
            child: GroupedEthnicityGraph.withEthnicityData(sizingInfo, createEthnicityData(model)),
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
            child: GroupedPartyGraph.withPartyData(sizingInfo,createPartyData(model)),
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

  


}
