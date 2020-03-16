import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/people/presentation/view_models/candidate_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data_by_candidate/data_cadidate.dart';

class PeopleViewMobile extends StatelessWidget {
  final CandidateViewModel model;

  PeopleViewMobile({Key key, this.model}) : super(key: key);
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
                          fontSize: headlineSize(sizingInfo)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(child: _candidatesStream(sizingInfo, model)),
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
                              Modular.to.pushReplacementNamed(Paths.issues);
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssueView()));
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
                              model.navigateToData();
                              // Modular.to.pushReplacementNamed(
                              //     Paths.dataByPersonality, arguments: model.selectedCandidate);
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder : (context)=> DataCandidateView(candidate : model.selectedCandidate)));
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

  Widget _candidatesStream(sizingInfo, CandidateViewModel model) {
    return StreamBuilder(
      stream: model.getCandidatesStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final snapshots = snapshot.data.documents;
          if (snapshots.length > 0) {
            return _buildPoepleList(sizingInfo, model, snapshots);
          } else {
            return Center(
                child: Text(
                    "No Personalities today.\n\nPlease check again later."));
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

  Widget _buildPoepleList(
    sizingInfo,
    CandidateViewModel model,
    List<DocumentSnapshot> snapshots,
  ) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: snapshots.length,
      itemBuilder: (BuildContext context, int index) {
        final candidate =
            Candidate.fromMap(snapshots[index].data, snapshots[index]);
        print(candidate);
        print(model.selectedCandidate);
        return InkWell(
            onTap: () {
              model.selectCandidate(candidate);
            },
            child: _peopleItem(context, candidate, model, sizingInfo));
      },
    );
  }

  Widget _peopleItem(
    BuildContext context,
    Candidate candidate,
    CandidateViewModel model,
    SizingInformation sizingInfo,
  ) {
    print(sizingInfo.screenSize);
    return Container(
    color: (model.selectedCandidate == candidate) ? themeData.primaryColor.withOpacity(0.1) : Colors.transparent,
      padding: EdgeInsets.only(left: 8),
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
                Text(candidate.party,
                    style: themeData.textTheme.body1.copyWith(
                      color: Colors.black38,
                      fontSize: (sizingInfo.screenSize.width < 400) ? 14 : 16,
                    )),
                Text(candidate.name,
                    style: themeData.textTheme.body1.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: (sizingInfo.screenSize.width < 400) ? 20 : 26,
                    )),
                ButtonBar(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          model.voteForPerson(candidate, 'agree');
                        },
                        child: Icon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.green,
                          size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                        )),
                    SizedBox(width: 1),
                    InkWell(
                        onTap: () {
                           model.voteForPerson(candidate, 'disagree');
                        },
                        child: Icon(
                          FontAwesomeIcons.thumbsDown,
                          color: Colors.red,
                          size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                        )),
                    SizedBox(width: 1),
                    InkWell(
                        onTap: () {
                           model.voteForPerson(candidate, 'undecided');
                        },
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
          ),
         
        ],
      ),
    );
  }
}
