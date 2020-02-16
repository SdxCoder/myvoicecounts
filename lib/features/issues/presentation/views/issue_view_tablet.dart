import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/people/people.dart';
import 'package:responsive_builder/responsive_builder.dart';

class IssueViewTablet extends StatelessWidget {
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
              Expanded(child: _buildIssueList(context, sizingInfo)),
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
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeopleView()));
                        },
                        color: Colors.yellow,
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
                        onPressed: () {},
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

Widget _buildIssueList(context, sizingInfo) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return _issueItem(context, index, sizingInfo);
    },
  );
}

Widget _issueItem(
    BuildContext context, int index, SizingInformation sizingInfo) {
  print(sizingInfo.screenSize);
  return SizedBox(
    height: sizingInfo.screenSize.height * 0.2,
    child: Row(
      children: <Widget>[
        SizedBox(
          height: sizingInfo.screenSize.height * 0.2,
          child: Center(
            child: Text("Enviornment",
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
                onTap: () {},
                child: Icon(FontAwesomeIcons.thumbsUp,
                    color: Colors.green,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(width: 8),
            InkWell(
                onTap: () {},
                child: Icon(FontAwesomeIcons.thumbsDown,
                    color: Colors.red,
                    size: sizingInfo.screenSize.width * 0.04)),
            SizedBox(width: 8),
            InkWell(
                onTap: () {},
                child: Icon(FontAwesomeIcons.timesCircle,
                    color: Colors.grey,
                    size: sizingInfo.screenSize.width * 0.04)),
          ],
        ),
      ],
    ),
  );
}
