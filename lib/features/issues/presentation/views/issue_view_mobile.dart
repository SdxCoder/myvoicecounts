import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/data/issue_model.dart';
import 'package:myvoicecounts/features/issues/presentation/view_models/issue_view_model.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data/data.dart';

class IssueViewMobile extends StatelessWidget {
  final IssueViewModel model;

  const IssueViewMobile({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
          title: Text('Core Issues', style: themeData.textTheme.body1),
          body: SizedBox(
            width: sizingInfo.screenSize.width,
            height: sizingInfo.screenSize.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(height: 24),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Bernie Sanders",
                  //     style: themeData.textTheme.body1.copyWith(
                  //         color: Colors.grey,
                  //         fontSize:
                  //             (sizingInfo.screenSize.height < 600) ? 20 : 26),
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  // Divider(
                  //   height: 0,
                  // ),
                  Expanded(child: _issuesStream(sizingInfo, model)),
                  Divider(
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
                              (sizingInfo.screenSize.width < 600) ? 40 : 70,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("PEOPLE",
                                style: themeData.textTheme.body1
                                    .copyWith(color: Colors.black87)),
                            onPressed: () {
                              Modular.to.pushReplacementNamed(Paths.people);
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeopleView()));
                            },
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(width: sizingInfo.screenSize.width * 0.1),
                       // Spacer(),
                        SizedBox(
                          width: sizingInfo.screenSize.width * 0.3,
                          height:
                              (sizingInfo.screenSize.width < 600) ? 40 : 70,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("DATA",
                                style: themeData.textTheme.body1.copyWith(
                                    color: Color(hexColor('f2f2f2')))),
                            onPressed: () {
                              model.navigateToData();
                              // Modular.to
                              //     .pushReplacementNamed(Paths.dataByIssue);
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataView()));
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


  Widget _issuesStream(sizingInfo,IssueViewModel model) {
    return StreamBuilder(
      stream: model.getIssuesStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final snapshots = snapshot.data.documents;
          if (snapshots.length > 0) {
            return _buildIssueList(sizingInfo, model, snapshots);
          } else {
            return Center(
                child: Text(
                    "No Issues today.\n\nPlease check again later."));
          }
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(themeData.primaryColor),
          ),
        );
      },
    );
  }


Widget _buildIssueList(
  sizingInfo,
  IssueViewModel model,
  List<DocumentSnapshot> snapshots,
  
) {
  return ListView.builder(
    
    physics: BouncingScrollPhysics(),
    itemCount: snapshots.length,
    itemBuilder: (BuildContext context, int index) {
       final issue =
            Issue.fromMap(snapshots[index].data, snapshots[index]);
      
       return InkWell(
            onTap: () {
              model.selectIssue(issue);
            },
            child: _issueItem(context, issue, model, sizingInfo));
      
    },
  );
}

Widget _issueItem(
  BuildContext context,
  Issue issue,
  IssueViewModel model,
  SizingInformation sizingInfo,
) {
  print(sizingInfo.screenSize);
  return Container(
    color: (model.selectedIssue == issue) ? themeData.primaryColor.withOpacity(0.1) : Colors.transparent,
    height: sizingInfo.screenSize.height * 0.2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: sizingInfo.screenSize.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal:8),
                width: sizingInfo.screenSize.width - 60,
                child: Text(issue.issueName,
                textAlign: TextAlign.center,
                maxLines: 2,
                    style: themeData.textTheme.body1.copyWith(
                      color:  Colors.black54,
                      fontWeight: (model.selectedIssue == issue) ? FontWeight.w900 : FontWeight.bold,
                      fontSize: (sizingInfo.screenSize.width < 400) ? 20 : 26,
                    )),
              ),
              SizedBox(height: sizingInfo.screenSize.height * 0.01),
              ButtonBar(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        model.voteForIssue(issue, "agree");
                      },
                      child: Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.green,
                        size: (sizingInfo.screenSize.width < 400) ? 26 : 32,
                      )),
                  SizedBox(width: 4),
                  InkWell(
                      onTap: () {
                        model.voteForIssue(issue, "disagree");
                      },
                      child: Icon(
                        FontAwesomeIcons.thumbsDown,
                        color: Colors.red,
                        size: (sizingInfo.screenSize.width < 400) ? 26 : 32,
                      )),
                  SizedBox(width: 4),
                  InkWell(
                      onTap: () {
                        model.voteForIssue(issue, "undecided");
                      },
                      child: Icon(
                        FontAwesomeIcons.questionCircle,
                        color: Colors.grey,
                        size: (sizingInfo.screenSize.width < 400) ? 26 : 32,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        
         
      ],
    ),
  );
}
