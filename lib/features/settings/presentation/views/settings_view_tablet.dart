import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../view_models/settings_view_model.dart';
import 'widgets/settings_dialogs.dart';

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
                    fontSize: headlineSize(sizingInfo)),
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
                        onTap: () async{
                           Map<String, dynamic> map =
                              await showStates(context, widget.model);
                          if (map["state"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                       onTap: () async {
                          Map<String, dynamic> map =
                              await showCity(context, widget.model);
                          if (map["city"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                        onTap: () async {
                          Map<String, dynamic> map =
                              await showZip(context, widget.model);
                          if (map["zip"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                        onTap: () async {
                          Map<String, dynamic> map =
                              await showAge(context, widget.model);
                          if (map["age"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                        onTap: () async {
                          Map<String, dynamic> map =
                              await showEthnicity(context, widget.model);
                          if (map["ethnicity"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                         onTap: () async {
                          Map<String, dynamic> map =
                              await showGender(context, widget.model);
                          if (map["gender"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                        onTap: () async {
                          Map<String, dynamic> map =
                              await showRace(context, widget.model);
                          if (map["race"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                        onTap: () async {
                          Map<String, dynamic> map =
                              await showParty(context, widget.model);
                          if (map["party"] != null) {
                            widget.model.updateUser(map);
                          } else {
                            print("closed");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                color: (widget.model.currentUser.state == null) ? Colors.red : Colors.transparent
                              ),
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
                  IconButton(
                    iconSize: 48,
                      icon: Icon(
                        Icons.info,
                        color: themeData.primaryColor,
                       
                      ),
                      onPressed: () {
                        (widget.model.showUpdateReminder() == false)
                            ? widget.model.showIntegretyControl()
                            : showInfoDialogBox(
                                title: "Reminder",
                                description:
                                    "Please update all the parameters of your profile",
                              );
                      }),
                    SizedBox(width: 20),
                  (widget.model.showUpdateReminder() == false)
                      ? Text(
                          "Integrity Control:\nEdit ${3 - widget.model.currentUser.integrity} of 3 total before erase",
                          style: themeData.textTheme.body1.copyWith(
                            color: themeData.primaryColorDark,
                            fontSize: headlineSize(sizingInfo)
                          ),
                        )
                      : Text(
                          "Please complete your profile",
                          style: themeData.textTheme.body1.copyWith(
                            color: themeData.primaryColorDark,
                            fontSize:headlineSize(sizingInfo),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      );
      }
    );
  }
}
