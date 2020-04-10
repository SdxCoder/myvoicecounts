import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../view_models/settings_view_model.dart';
import 'widgets/settings_dialogs.dart';

class SettingsViewMobile extends StatefulWidget {
  final SettingsViewModel model;

  const SettingsViewMobile({Key key, this.model}) : super(key: key);
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
        title: Text(
          "How I Self-Identify",
          style: themeData.textTheme.body1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  print("how this works");
                  widget.model.openDescription();
                },
                child: Text(
                  "How this works",
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.black54,
                      fontSize: headlineSize(sizingInfo)),
                ),
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
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      InkWell(
                        onTap: () async {
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
                              border: Border.all(
                                  color:
                                      (widget.model.currentUser.state == null)
                                          ? Colors.red
                                          : Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan),
                          child: Text(
                            "State",
                            style: themeData.textTheme.body1,
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
                                  color: (widget.model.currentUser.city == null)
                                      ? Colors.red
                                      : Colors.transparent),
                              color: Colors.cyan),
                          child: Text(
                            "City",
                            style: themeData.textTheme.body1,
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
                                  color: (widget.model.currentUser.zip == null)
                                      ? Colors.red
                                      : Colors.transparent),
                              color: Colors.cyan),
                          child: Text(
                            "Zip",
                            style: themeData.textTheme.body1,
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
                                  color: (widget.model.currentUser.age == null)
                                      ? Colors.red
                                      : Colors.transparent),
                              color: themeData.accentColor),
                          child: Text(
                            "Age",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white),
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
                                  color: (widget.model.currentUser.ethnicity ==
                                          null)
                                      ? Colors.red
                                      : Colors.transparent),
                              color: themeData.accentColor),
                          child: Text(
                            "Ethnicity",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      (widget.model.currentUser.gender == null)
                                          ? Colors.red
                                          : Colors.transparent),
                              color: themeData.accentColor),
                          child: Text(
                            "Gender",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white),
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
                                  color: (widget.model.currentUser.race == null)
                                      ? Colors.red
                                      : Colors.transparent),
                              color: themeData.primaryColor),
                          child: Text(
                            "Race",
                            style: themeData.textTheme.body1
                                .copyWith(color: Colors.white),
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
                                  color:
                                      (widget.model.currentUser.party == null)
                                          ? Colors.red
                                          : Colors.transparent),
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
              Row(
                children: <Widget>[
                  IconButton(
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
                  (widget.model.showUpdateReminder() == false)
                      ? Text(
                          "Integrity Control:\nEdit ${3 - widget.model.currentUser.integrity} of 3 total before erase",
                          style: themeData.textTheme.body1.copyWith(
                            color: themeData.primaryColorDark,
                            fontSize: sizingInfo.screenSize.width * 0.05,
                          ),
                        )
                      : Text(
                          "Please complete your profile",
                          style: themeData.textTheme.body1.copyWith(
                            color: themeData.primaryColorDark,
                            fontSize: sizingInfo.screenSize.width * 0.05,
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
