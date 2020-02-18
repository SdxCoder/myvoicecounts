import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';

class SettingsViewMobile extends StatefulWidget {
  @override
  _SettingsViewMobileState createState() => _SettingsViewMobileState();
}

class _SettingsViewMobileState extends State<SettingsViewMobile> {
  List<Widget> wds = [];

  @override
  void initState() {
    super.initState();
    wds.add(Text("sss"));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
        title: Text("How I Self-Identify"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: <Widget>[
              Text(
                "How this works?",
                style: themeData.textTheme.body1.copyWith(
                    color: Colors.black54,
                    fontSize: sizingInfo.screenSize.width * 0.08),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 0,
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
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
                            style: themeData.textTheme.body1,
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
                            style: themeData.textTheme.body1,
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
                            style: themeData.textTheme.body1,
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
                                .copyWith(color: Colors.white),
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
                                .copyWith(color: Colors.white),
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
                                .copyWith(color: Colors.white),
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
                                .copyWith(color: Colors.white),
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
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
              Divider(
                height: 0,
                color: themeData.primaryColorDark,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Integrity Control:\nEdit 2 of 3 total before erase",
                style: themeData.textTheme.body1.copyWith(
                  color: themeData.primaryColorDark,
                  fontSize: sizingInfo.screenSize.width * 0.05,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
