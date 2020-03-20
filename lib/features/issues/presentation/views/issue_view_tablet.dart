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

class IssueViewTablet extends StatelessWidget {
  final IssueViewModel model;

  const IssueViewTablet({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
          body: SizedBox(
        width: sizingInfo.screenSize.width,
        height: sizingInfo.screenSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            children: <Widget>[
              SizedBox(height: sizingInfo.screenSize.height * 0.05),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Bernie Sanders",
                  style: themeData.textTheme.display4.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: sizingInfo.screenSize.height * 0.05),
              Divider(
                height: 0,
              ),
              Expanded(child: _issuesStream( sizingInfo, model)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: sizingInfo.screenSize.width * 0.3,
                      height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("PEOPLE",
                            style: themeData.textTheme.display2
                                .copyWith(color: Colors.black87)),
                        onPressed: () {
                          model.navigateToData();
                          // Modular.to.pushReplacementNamed(Paths.people);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeopleView()));
                        },
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(width: sizingInfo.screenSize.width * 0.1),
                    SizedBox(
                      width: sizingInfo.screenSize.width * 0.3,
                      height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("DATA",
                            style: themeData.textTheme.display2
                                .copyWith(color: Color(hexColor('f2f2f2')))),
                        onPressed: () {
                          model.navigateToData();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataView()));
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

Widget _issuesStream(sizingInfo, IssueViewModel model) {
  return StreamBuilder(
    stream: model.getIssuesStream(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        final snapshots = snapshot.data.documents;
        if (snapshots.length > 0) {
          return _buildIssueList(sizingInfo, model, snapshots);
        } else {
          return Center(
              child: Text("No Issues today.\n\nPlease check again later."));
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
      final issue = Issue.fromMap(snapshots[index].data, snapshots[index]);

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
      children: <Widget>[
        SizedBox(
          height: sizingInfo.screenSize.height * 0.2,
          child: Center(
            child: Text(issue.issueName,
                style: (sizingInfo.screenSize.height < 800)
                    ? themeData.textTheme.display3.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold)
                    : themeData.textTheme.display4.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold)),
          ),
        ),
        Spacer(),
        ButtonBar(
          children: <Widget>[
            InkWell(
                onTap: () {
                  model.voteForIssue(issue, 'agree');
                },
                child: Icon(FontAwesomeIcons.thumbsUp,
                    color: Colors.green,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(width: 8),
            InkWell(
                onTap: () {
                   model.voteForIssue(issue, 'disagree');
                },
                child: Icon(FontAwesomeIcons.thumbsDown,
                    color: Colors.red,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(width: 8),
            InkWell(
                onTap: () {
                   model.voteForIssue(issue, 'undecided');
                },
                child: Icon(FontAwesomeIcons.timesCircle,
                    color: Colors.grey,
                    size: sizingInfo.screenSize.width * 0.04)),
          ],
        ),
      ],
    ),
  );
}
