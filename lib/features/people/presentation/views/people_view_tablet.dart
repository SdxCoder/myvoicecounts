import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/issues/issues.dart';
import 'package:myvoicecounts/features/people/data/candidate.dart';
import 'package:myvoicecounts/features/people/presentation/view_models/candidate_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data_by_candidate/data_cadidate.dart';

class PeopleViewTablet extends StatelessWidget {
  final CandidateViewModel model;

  const PeopleViewTablet({Key key, this.model}) : super(key: key);

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
                  "Would I Vote for You Today?",
                  style: themeData.textTheme.display4.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: sizingInfo.screenSize.height * 0.05),
              Expanded(child: _candidatesStream(context, model)),
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
                        child: Text("ISSUES",
                            style: themeData.textTheme.display2
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
                      height: (sizingInfo.screenSize.height < 600) ? 40 : 70,
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("DATA",
                            style: themeData.textTheme.display2
                                .copyWith(color: Color(hexColor('f2f2f2')))),
                        onPressed: () {
                          Modular.to
                              .pushReplacementNamed(Paths.dataByPersonality);
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataCandidateView()));
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
              child:
                  Text("No Personalities today.\n\nPlease check again later."));
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
    height: sizingInfo.screenSize.height * 0.3,
    child: Row(
      children: <Widget>[
        SizedBox(
          height: sizingInfo.screenSize.height * 0.2,
          child: CircleAvatar(
            minRadius: sizingInfo.screenSize.height * 0.1,
            backgroundImage: AssetImage('images/donald.jpg'),
          ),
        ),
        SizedBox(width: sizingInfo.screenSize.height * 0.1),
        SizedBox(
          height: sizingInfo.screenSize.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Republican Party",
                  style: (sizingInfo.screenSize.height < 800)
                      ? themeData.textTheme.display2.copyWith(
                          color: Colors.black38,
                        )
                      : themeData.textTheme.display3.copyWith(
                          color: Colors.black38,
                        )),
              Text("Donald Trump",
                  style: (sizingInfo.screenSize.height < 800)
                      ? themeData.textTheme.display3.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.bold)
                      : themeData.textTheme.display4.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Spacer(),
        ButtonBar(
          children: <Widget>[
            InkWell(
                onTap: () {
                   model.voteForPerson(candidate, 'agree');
                },
                child: Icon(FontAwesomeIcons.thumbsUp,
                    color: Colors.green,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(
              width: 1,
            ),
            InkWell(
                onTap: () {
                   model.voteForPerson(candidate, 'disagree');
                },
                child: Icon(FontAwesomeIcons.thumbsDown,
                    color: Colors.red,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(
              width: 1,
            ),
            InkWell(
              onTap: () {
                 model.voteForPerson(candidate, 'undecided');
              },
              child: Icon(FontAwesomeIcons.timesCircle,
                  color: Colors.grey, size: sizingInfo.screenSize.width * 0.04),
            ),
          ],
        ),
        
      ],
    ),
  );
}
