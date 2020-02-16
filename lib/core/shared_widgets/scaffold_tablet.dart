import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvoicecounts/features/home/home.dart';

import '../core.dart';

class ScaffoldTablet extends StatelessWidget {
  final Widget body;

  ScaffoldTablet({Key key, this.body}) : super(key: key);
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
          padding: const EdgeInsets.only(top: 16.0,left: 16, bottom: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    }),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {}),
              ]),
        ),
        Container(
            margin: EdgeInsets.only(left: 70),
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
