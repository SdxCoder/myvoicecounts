import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';

Future<void> showInfoDialogBox({
  @required String title,
  @required String description,
  String buttonText = "OK",
}) async {
  print("show dialog");
  await showDialog<void>(
    context: Modular.navigatorKey.currentState.overlay.context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Divider(),
                  Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text("$description."),
                    ],
                  ),
                  Divider(),
                  Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: themeData.accentColor,
                        elevation: 0,
                        child: Text(buttonText),
                        onPressed: () {
                          Modular.navigatorKey.currentState.pop();
                        },
                      )),
                ]),
          ),
        ),
      );
    },
  );
}

Future<void> showActionDialogBox(
    {@required String title,
    @required String description,
    Function onPressedYes,
    Function onPressedNo,
    String buttonText = "Yes",
    String buttonTextCancel = "No"}) async {
  print("show dialog");
  await showDialog<void>(
    context: Modular.navigatorKey.currentState.overlay.context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        actions: <Widget>[
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(buttonTextCancel,
                  style: TextStyle(color: themeData.accentColor)),
              onPressed: onPressedNo),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: themeData.accentColor,
              elevation: 0,
              child: Text(buttonText),
              onPressed: onPressedYes),
        ],
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Divider(),
                  Text(
                    "$description.",
                    textAlign: TextAlign.center,
                  ),
                ]),
          ),
        ),
      );
    },
  );
}

Future<void> showActionSettingsDialogBox(
    {@required String title,
    @required String description,
    @required String url,
    Function onPressedYes,
    Function onPressedNo,
    String buttonText = "Yes",
    String buttonTextCancel = "No"}) async {
  print("show dialog");
  await showDialog<void>(
    context: Modular.navigatorKey.currentState.overlay.context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        actions: <Widget>[
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(buttonTextCancel,
                  style: TextStyle(color: themeData.accentColor)),
              onPressed: onPressedNo),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: themeData.accentColor,
              elevation: 0,
              child: Text(buttonText),
              onPressed: onPressedYes),
        ],
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  // Divider(),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "$description.",
                            style: TextStyle(color: Colors.black54)),
                        TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: url,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      );
    },
  );
}

Future<String> showCalenderDialogBox(
    {@required String title,
    @required Widget content,
    model,
    String buttonText = "OK",
    String buttonTextCancel = "Close"}) async {
  print("show dialog");
  return await showDialog<String>(
    context: Modular.navigatorKey.currentState.overlay.context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Padding(padding: const EdgeInsets.all(16.0), child: content),
                  SizedBox(height: 16),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(buttonTextCancel,
                              style: TextStyle(color: themeData.accentColor)),
                          onPressed: () {
                            String result = "false";
                            return Modular.to.pop(result);
                          }),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: themeData.accentColor,
                          elevation: 0,
                          child: Text(buttonText),
                          onPressed: () {
                            return Modular.to.pop("true");
                          }),
                    ],
                  ),
                ]),
          ),
        ),
      );
    },
  );
}

Future showSnackBarInfo({String desc}) {
  var context = Modular.navigatorKey.currentState.overlay.context;
  Flushbar flush;

  flush = Flushbar(
    messageText: Text(
      desc,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    mainButton: FlatButton(
        onPressed: () {
          flush.dismiss(true);
        },
        child: Text(
          "DISMISS",
          style: themeData.textTheme.button,
        )),
    backgroundColor: themeData.primaryColor,
    flushbarPosition: FlushbarPosition.BOTTOM,
    padding: EdgeInsets.all(8),
    barBlur: 0.0001,
    // overlayColor: overlayColor,
    borderRadius: 0,
    icon: Icon(
      Icons.info,
      color: themeData.primaryColor,
    ),
    duration: Duration(seconds: 3),
  )..show(context);
}
