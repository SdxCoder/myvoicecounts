import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/settings/presentation/view_models/settings_view_model.dart';

Future<Map<String, dynamic>> showStates(
    context, SettingsViewModel model) async {
  String title = "Select a state";
  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${model.currentUser.state ?? title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.allStates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(model.allStates[index]),
                        onTap: () {
                          print(model.allStates[index]);
                          Map<String, dynamic> map = {
                            "state": model.allStates[index],
                          };
                          return Modular.navigatorKey.currentState.pop(map);
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: themeData.accentColor,
                      elevation: 0,
                      child: Text("Close"),
                      onPressed: () {
                        return Modular.navigatorKey.currentState
                            .pop({"state": null});
                      },
                    )),
              ]),
        ),
      );
    },
  );
}

Future<Map<String, dynamic>> showEthnicity(
    context, SettingsViewModel model) async {
  String title = "Select ethnicity";
  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${model.currentUser.ethnicity ?? title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.ethnicity.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(model.ethnicity[index]),
                        onTap: () {
                          print(model.ethnicity[index]);
                          Map<String, dynamic> map = {
                            "ethnicity": model.ethnicity[index],
                          };
                          return Modular.navigatorKey.currentState.pop(map);
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: themeData.accentColor,
                      elevation: 0,
                      child: Text("Close"),
                      onPressed: () {
                        return Modular.navigatorKey.currentState
                            .pop({"ethnicity": null});
                      },
                    )),
              ]),
        ),
      );
    },
  );
}

Future<Map<String, dynamic>> showRace(context, SettingsViewModel model) async {
  String title = "Select race";
  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${model.currentUser.race ?? title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.race.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(model.race[index]),
                        onTap: () {
                          print(model.race[index]);
                          Map<String, dynamic> map = {
                            "race": model.race[index],
                          };
                          return Modular.navigatorKey.currentState.pop(map);
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: themeData.accentColor,
                      elevation: 0,
                      child: Text("Close"),
                      onPressed: () {
                        return Modular.navigatorKey.currentState
                            .pop({"race": null});
                      },
                    )),
              ]),
        ),
      );
    },
  );
}

Future<Map<String, dynamic>> showParty(context, SettingsViewModel model) async {
  String title = "Select Party";
  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${model.currentUser.party ?? title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.party.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(model.party[index]),
                        onTap: () {
                          print(model.party[index]);
                          Map<String, dynamic> map = {
                            "party": model.party[index],
                          };
                          return Modular.navigatorKey.currentState.pop(map);
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: themeData.accentColor,
                      elevation: 0,
                      child: Text("Close"),
                      onPressed: () {
                        return Modular.navigatorKey.currentState
                            .pop({"party": null});
                      },
                    )),
              ]),
        ),
      );
    },
  );
}
  
  Future<Map<String, dynamic>> showGender(
      context, SettingsViewModel model) async {
        String title = "Select Gender";
   return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${model.currentUser.gender ?? title}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.gender.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(model.gender[index]),
                          onTap: () {
                            print(model.gender[index]);
                            Map<String , dynamic> map = {
                              "gender" : model.gender[index],
                            };
                            return Modular.navigatorKey.currentState.pop(map);
                          },
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: themeData.accentColor,
                        elevation: 0,
                        child: Text("Close"),
                        onPressed: () {
                          return Modular.navigatorKey.currentState.pop({
                            "gender" : null
                          });
                        },
                      )),
                ]),
          ),
        );
      },
    );

      }


 
  Future<Map<String, dynamic>> showZip(
      context, SettingsViewModel model) async {
        String title = "Enter your zip code";
   return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${model.currentUser.zip ?? title}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Divider(),
                // text
                  Divider(),
                  Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: themeData.accentColor,
                        elevation: 0,
                        child: Text("Close"),
                        onPressed: () {
                          return Modular.navigatorKey.currentState.pop({
                            "zip" : null
                          });
                        },
                      )),
                ]),
          ),
        );
      },
    );

      }


