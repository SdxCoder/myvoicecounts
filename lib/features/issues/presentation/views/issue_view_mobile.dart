import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class IssueViewMobile extends StatelessWidget {
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
                children: <Widget>[
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bernie Sanders",
                      style: themeData.textTheme.body1.copyWith(
                          color: Colors.grey,
                          fontSize:
                              (sizingInfo.screenSize.height < 600) ? 20 : 26),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(height: 0,),
                  
                  Expanded(child: _buildIssueList(context, sizingInfo)),
                   Divider(
                    color: themeData.primaryColorDark,
                  ),
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                      SizedBox(
                        width: sizingInfo.screenSize.width * 0.3,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                        child: RaisedButton(
                           elevation: 0,
                           shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          child: Text("PEOPLE",
                              style: themeData.textTheme.body1
                                  .copyWith(color: Colors.black87)),
                          onPressed: () {},
                          color: Colors.yellow,
                        ),
                      ),
                      Spacer(),
                       SizedBox(
                        width: sizingInfo.screenSize.width * 0.3,
                        height: (sizingInfo.screenSize.height < 600) ? 40 : 48,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          child: Text("DATA",
                              style: themeData.textTheme.body1
                                  .copyWith(color: Color(hexColor('f2f2f2')))),
                          onPressed: () {},
                          color: Colors.green,
                        ),
                       ),
                    ]),
                     SizedBox(height: 16),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: sizingInfo.screenSize.height*0.2,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Enviornment",
                  style: themeData.textTheme.body1.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: (sizingInfo.screenSize.width < 400) ? 20 : 26,
                  )),
              SizedBox(height: sizingInfo.screenSize.height*0.01),
              ButtonBar(
                children: <Widget>[
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.green,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsDown,
                        color: Colors.red,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  InkWell(
                      onTap: () {},
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
        )
      ],
    ),
  );
}
