import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/features/home/home.dart';

import '../core.dart';

class ScaffoldMobile extends StatelessWidget {
  final Widget title;
  final Widget body;

  ScaffoldMobile({Key key, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 70,
            decoration: BoxDecoration(color: themeData.primaryColorLight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                }),
            (Platform.isIOS)
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: title,
                  )
                : title,
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {}),
          ]),
        ),
        Container(
            margin: EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
              gradient: gradientHome,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: body),
      ],
    );
  }
}
