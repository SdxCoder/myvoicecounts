import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../view_models/settings_view_model.dart';

class SettingsViewTablet extends StatefulWidget {
  final SettingsViewModel model;

  const SettingsViewTablet({Key key, this.model}) : super(key: key);

  @override
  _SettingsViewTabletState createState() => _SettingsViewTabletState();
}

class _SettingsViewTabletState extends State<SettingsViewTablet> {
  List<Widget> wds = [];

  @override
  void initState() {
    super.initState();
    wds.add(Text("sss"));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) { 
        print(sizingInfo.screenSize.aspectRatio);
        return ScaffoldTablet(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          child: Column(
            children: <Widget>[
              Text(
                "How this works",
                style: themeData.textTheme.body1.copyWith(
                    color: Colors.black54,
                    fontSize: sizingInfo.screenSize.height * 0.08),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 0,
              ),
               SizedBox(
                height: sizingInfo.screenSize.height * 0.05,
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: (sizingInfo.screenSize.aspectRatio > 1.4) ? 5 : 4,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan),
                          child: Text(
                            "State",
                            style: themeData.textTheme.body1.copyWith(
                              fontSize : sizingInfo.screenSize.width*0.03
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan),
                          child: Text(
                            "City",
                            style:  themeData.textTheme.display3.copyWith(
                              fontSize : sizingInfo.screenSize.width*0.03
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan),
                          child: Text(
                            "Zip",
                            style:  themeData.textTheme.display3.copyWith(
                              fontSize : sizingInfo.screenSize.width*0.03
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeData.accentColor),
                          child: Text(
                            "Age",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white,
                                 fontSize : sizingInfo.screenSize.width*0.03),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeData.accentColor),
                          child: Text(
                            "Ethnicity",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white,
                                 fontSize : sizingInfo.screenSize.width*0.03
                                ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeData.accentColor),
                          child: Text(
                            "Gender",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white, 
                                 fontSize : sizingInfo.screenSize.width*0.03),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeData.primaryColor),
                          child: Text(
                            "Race",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white, 
                                 fontSize : sizingInfo.screenSize.width*0.03),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeData.primaryColor),
                          child: Text(
                            "Party",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white, 
                                 fontSize : sizingInfo.screenSize.width*0.03),
                          ),
                        ),
                      ),
                    ]),
              ),
               SizedBox(
                height: sizingInfo.screenSize.height * 0.05,
              ),
              Divider(
                height: 0,
                color: themeData.primaryColorDark,
              ),
              SizedBox(
                height: 16,
              ),
               Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.info, color: themeData.primaryColor,), onPressed: (){
                    widget.model.showIntegretyControl();
                  }),
                  Text(
                    "Integrity Control:\nEdit 2 of 3 total before erase",
                    style: themeData.textTheme.body1.copyWith(
                      color: themeData.primaryColorDark,
                      fontSize: sizingInfo.screenSize.width * 0.05,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
      }
    );
  }
}
